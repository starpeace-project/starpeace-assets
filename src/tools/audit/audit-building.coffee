
path = require('path')
fs = require('fs')
_ = require('lodash')

AuditUtils = require('../utils/audit-utils')
FileUtils = require('../utils/file-utils')

{ BuildingDefinition, BuildingImageDefinition, SimulationDefinitionParser } = require('@starpeace/starpeace-assets-types')


exports = module.exports = class AuditBuilding
  @EXPECTED_DEFINITION_COUNT: 321
  @EXPECTED_IMAGE_DEFINITION_COUNT: 412
  @EXPECTED_SIMULATION_DEFINITION_COUNT: 321

  @audit: (root_dir) -> (audit_data) -> new Promise (resolve, reject) ->
    try
      console.log " [OK] starting building audit...\n"

      definitions = FileUtils.parse_files(root_dir, ['.json'], ['-simulation.json', '-image.json'], BuildingDefinition.fromJson)
      definitions_by_id = _.keyBy(definitions, 'id')
      AuditUtils.audit_is_valid('building definition', definitions)
      AuditUtils.audit_unique_count_by_id('building definition', definitions, definitions_by_id, AuditBuilding.EXPECTED_DEFINITION_COUNT)

      process.stdout.write '\n'

      image_definitions = FileUtils.parse_files(root_dir, ['-image.json'], [], BuildingImageDefinition.fromJson)
      image_definitions_by_id = _.keyBy(image_definitions, 'id')
      AuditUtils.audit_is_valid('building image definition', image_definitions)
      AuditUtils.audit_unique_count_by_id('building image definition', image_definitions, image_definitions_by_id, AuditBuilding.EXPECTED_IMAGE_DEFINITION_COUNT)

      process.stdout.write '\n'

      simulation_definitions = FileUtils.parse_files(root_dir, ['-simulation.json'], [], SimulationDefinitionParser.fromJson)
      simulation_definitions_by_id = _.keyBy(simulation_definitions, 'id')

      AuditUtils.audit_is_valid('building simulation definition', simulation_definitions)
      AuditUtils.audit_unique_count_by_id('building simulation definition', simulation_definitions, simulation_definitions_by_id, AuditBuilding.EXPECTED_SIMULATION_DEFINITION_COUNT)

      process.stdout.write '\n'

      definitions_with_unknown_simulation_definitions = _.filter(definitions, (definition) -> !simulation_definitions_by_id[definition.id]?)
      if definitions_with_unknown_simulation_definitions.length
        console.log " [WARN] building definition #{definition.id} has unknown definition reference" for definition in definitions_with_unknown_simulation_definitions
      else
        console.log " [OK] all building definitions have valid simulation definition references"

      process.stdout.write '\n'

      definitions_with_unknown_images = _.filter(definitions, (definition) -> !image_definitions_by_id[definition.imageId]? || !image_definitions_by_id[definition.constructionImageId]?)
      if definitions_with_unknown_images.length
        console.log " [ERROR] building definition #{definition.id} has unknown image references #{definition.imageId} or #{definition.constructionImageId}" for definition in definitions_with_unknown_images
        throw "found #{definitions_with_unknown_images.length} building definitions with unknown imageId or constructionImageId references"
      else
        console.log " [OK] all building definitions have valid imageId and constructionImageId references"

      definitions_with_unknown_zones = _.filter(definitions, (definition) -> !audit_data.industry.city_zones_by_id[definition.zoneId]?)
      if definitions_with_unknown_zones.length
        console.log " [ERROR] building definition #{definition.id} has unknown city zone references #{definition.zoneId}" for definition in definitions_with_unknown_zones
        throw "found #{definitions_with_unknown_zones.length} building definitions with unknown city zone references"
      else
        console.log " [OK] all building definitions have valid city zone references"

      definitions_with_unknown_categories = _.filter(definitions, (definition) -> !audit_data.industry.industry_categories_by_id[definition.industryCategoryId]?)
      if definitions_with_unknown_categories.length
        console.log " [ERROR] building definition #{definition.id} has unknown category references #{definition.industryCategoryId}" for definition in definitions_with_unknown_categories
        throw "found #{definitions_with_unknown_categories.length} building definitions with unknown industry category references"
      else
        console.log " [OK] all building definitions have valid industry category references"

      definitions_with_unknown_types = _.filter(definitions, (definition) -> !audit_data.industry.industry_types_by_id[definition.industryTypeId]?)
      if definitions_with_unknown_types.length
        console.log " [ERROR] building definition #{definition.id} has unknown industry type references #{definition.industryTypeId}" for definition in definitions_with_unknown_types
        throw "found #{definitions_with_unknown_types.length} building definitions with unknown industry type references"
      else
        console.log " [OK] all building definitions have valid industry type references"

      definitions_with_unknown_seals = _.filter(definitions, (definition) -> !audit_data.seal.company_seals_by_id[definition.sealId]?)
      if definitions_with_unknown_seals.length
        console.log " [ERROR] building definition #{definition.id} has unknown seal references #{definition.sealId}" for definition in definitions_with_unknown_seals
        throw "found #{definitions_with_unknown_seals.length} building definitions with unknown seal references"
      else
        console.log " [OK] all building definitions have valid seal references"

      process.stdout.write '\n'

      simulation_definitions_with_unknown_definitions = _.filter(simulation_definitions, (definition) -> !definitions_by_id[definition.id]?)
      if simulation_definitions_with_unknown_definitions.length
        console.log " [ERROR] building simulation definition #{definition.id} has unknown definition reference" for definition in simulation_definitions_with_unknown_definitions
        throw "found #{simulation_definitions_with_unknown_definitions.length} building simulation definitions with unknown definition references"
      else
        console.log " [OK] all building simulation definitions have valid definition references"

      definitions_with_unknown_inventions = _.filter(definitions, (definition) -> definition.requiredInventionIds.length && _.find(definition.requiredInventionIds, (id) -> !audit_data.invention.definitions_by_id[id]?)?)
      if definitions_with_unknown_inventions.length
        console.log " [ERROR] building definition #{definition.id} has unknown required invention references" for definition in definitions_with_unknown_inventions
        throw "found #{definitions_with_unknown_inventions.length} building definitions with unknown required invention references"
      else
        console.log " [OK] all building definitions have valid required invention references"

      console.log "\n [OK] finished building audit successfully\n"
      console.log "-------------------------------------------------------------------------------\n"
      resolve(_.merge(audit_data, {
        building: {
          definitions_by_id
          image_definitions_by_id
          simulation_definitions_by_id
        }
      }))
    catch err
      reject(err)
