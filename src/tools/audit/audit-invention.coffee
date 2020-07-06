
path = require('path')
fs = require('fs')
_ = require('lodash')

AuditUtils = require('../utils/audit-utils')
FileUtils = require('../utils/file-utils')

STARPEACE = require('@starpeace/starpeace-assets-types')


exports = module.exports = class AuditInvention
  @EXPECTED_INVENTION_COUNT: 872

  @audit: (root_dir) -> (audit_data) -> new Promise (resolve, reject) ->
    try
      console.log " [OK] starting invention audit...\n"

      definitions = FileUtils.parse_files(root_dir, ['.json'], [], STARPEACE.invention.InventionDefinition.from_json)
      definitions_by_id = _.keyBy(definitions, 'id')
      AuditUtils.audit_is_valid('invention definition', definitions)
      AuditUtils.audit_unique_count_by_id('invention definition', definitions, definitions_by_id, AuditInvention.EXPECTED_INVENTION_COUNT)

      process.stdout.write '\n'

      definitions_with_unknown_categories = _.filter(definitions, (definition) -> !audit_data.industry.industry_categories_by_id[definition.industry_category_id]?)
      if definitions_with_unknown_categories.length
        console.log " [ERROR] invention definition #{definition.id} has unknown category references #{definition.industry_category_id}" for definition in definitions_with_unknown_categories
        throw "found #{definitions_with_unknown_categories.length} invention definitions with unknown industry category references"
      else
        console.log " [OK] all invention definitions have valid industry category references"

      definitions_with_unknown_types = _.filter(definitions, (definition) -> !audit_data.industry.industry_types_by_id[definition.industry_type_id]?)
      if definitions_with_unknown_types.length
        console.log " [ERROR] invention definition #{definition.id} has unknown industry type references #{definition.industry_type_id}" for definition in definitions_with_unknown_types
        throw "found #{definitions_with_unknown_types.length} invention definitions with unknown industry type references"
      else
        console.log " [OK] all invention definitions have valid industry type references"

      definitions_with_unknown_dependencies = _.filter(definitions, (definition) -> _.find(definition.depends_on_ids, (depend_id) -> !definitions_by_id[depend_id]?)?)
      if definitions_with_unknown_dependencies.length
        console.log " [ERROR] invention definition #{definition.id} has unknown dependency reference #{definition.depends_on_ids}" for definition in definitions_with_unknown_dependencies
        throw "found #{definitions_with_unknown_dependencies.length} invention definitions with unknown depends_on_ids references"
      else
        console.log " [OK] all invention definitions have valid depends_on_ids references"

      definitions_with_unknown_property_level = _.filter(definitions, (definition) -> definition.properties.levelId? && !audit_data.industry.levels_by_id[definition.properties.levelId]?)
      if definitions_with_unknown_property_level.length
        console.log " [ERROR] invention definition #{definition.id} has unknown level references #{definition.properties.levelId}" for definition in definitions_with_unknown_property_level
        throw "found #{definitions_with_unknown_zones.length} invention definitions with unknown level references"
      else
        console.log " [OK] all invention definitions have valid level references"


      console.log "\n [OK] finished invention audit successfully\n"
      console.log "-------------------------------------------------------------------------------\n"
      resolve(_.merge(audit_data, {
        invention: {
          definitions_by_id
        }
      }))
    catch err
      reject(err)
