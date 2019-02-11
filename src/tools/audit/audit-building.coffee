
path = require('path')
fs = require('fs')
_ = require('lodash')

AuditUtils = require('../utils/audit-utils')
FileUtils = require('../utils/file-utils')

{
  BuildingDefinition
  BuildingImageDefinition
  BuildingSimulationDefinition
} = require('../../lib')


exports = module.exports = class AuditBuilding
  @EXPECTED_DEFINITION_COUNT: 296
  @EXPECTED_IMAGE_DEFINITION_COUNT: 417
  @EXPECTED_SIMULATION_DEFINITION_COUNT: 105

  @audit: (root_dir) -> (audit_data) -> new Promise (resolve, reject) ->
    try
      console.log " [OK] starting building audit...\n"

      definitions = FileUtils.parse_files(root_dir, ['.json'], ['-simulation.json', '-image.json'], BuildingDefinition.from_json)
      definitions_by_id = _.keyBy(definitions, 'id')
      AuditUtils.audit_is_valid('building definition', definitions)
      AuditUtils.audit_unique_count_by_id('building definition', definitions, definitions_by_id, AuditBuilding.EXPECTED_DEFINITION_COUNT)

      process.stdout.write '\n'

      image_definitions = FileUtils.parse_files(root_dir, ['-image.json'], [], BuildingImageDefinition.from_json)
      image_definitions_by_id = _.keyBy(image_definitions, 'id')
      AuditUtils.audit_is_valid('building image definition', image_definitions)
      AuditUtils.audit_unique_count_by_id('building image definition', image_definitions, image_definitions_by_id, AuditBuilding.EXPECTED_IMAGE_DEFINITION_COUNT)

      process.stdout.write '\n'

      simulation_definitions = FileUtils.parse_files(root_dir, ['-simulation.json'], [], BuildingSimulationDefinition.from_json)
      simulation_definitions_by_id = _.keyBy(simulation_definitions, 'id')
      AuditUtils.audit_is_valid('building simulation definition', simulation_definitions)
      AuditUtils.audit_unique_count_by_id('building simulation definition', simulation_definitions, simulation_definitions_by_id, AuditBuilding.EXPECTED_SIMULATION_DEFINITION_COUNT)

      process.stdout.write '\n'

      definitions_with_unknown_images = _.filter(definitions, (definition) -> !image_definitions_by_id[definition.image_id]? || !image_definitions_by_id[definition.construction_image_id]?)
      if definitions_with_unknown_images.length
        console.log " [ERROR] building definition #{definition.id} has unknown image references #{definition.image_id} or #{definition.construction_image_id}" for definition in definitions_with_unknown_images
        throw "found #{definitions_with_unknown_images.length} building definitions with unknown image_id or construction_image_id references"
      else
        console.log " [OK] all building definitions have valid image_id and construction_image_id references"

      definitions_with_unknown_zones = _.filter(definitions, (definition) -> !audit_data.industry.city_zones_by_id[definition.zone]?)
      if definitions_with_unknown_zones.length
        console.log " [ERROR] building definition #{definition.id} has unknown city zone references #{definition.zone}" for definition in definitions_with_unknown_zones
        throw "found #{definitions_with_unknown_zones.length} building definitions with unknown city zone references"
      else
        console.log " [OK] all building definitions have valid city zone references"

      definitions_with_unknown_categories = _.filter(definitions, (definition) -> !audit_data.industry.industry_categories_by_id[definition.category]?)
      if definitions_with_unknown_categories.length
        console.log " [ERROR] building definition #{definition.id} has unknown category references #{definition.category}" for definition in definitions_with_unknown_categories
        throw "found #{definitions_with_unknown_categories.length} building definitions with unknown industry category references"
      else
        console.log " [OK] all building definitions have valid industry category references"

      definitions_with_unknown_types = _.filter(definitions, (definition) -> !audit_data.industry.industry_types_by_id[definition.industry_type]?)
      if definitions_with_unknown_types.length
        console.log " [ERROR] building definition #{definition.id} has unknown industry type references #{definition.industry_type}" for definition in definitions_with_unknown_types
        throw "found #{definitions_with_unknown_types.length} building definitions with unknown industry type references"
      else
        console.log " [OK] all building definitions have valid industry type references"

      definitions_with_unknown_seals = _.filter(definitions, (definition) -> !audit_data.seal.company_seals_by_id[definition.seal_id]?)
      if definitions_with_unknown_seals.length
        console.log " [ERROR] building definition #{definition.id} has unknown seal references #{definition.seal_id}" for definition in definitions_with_unknown_seals
        throw "found #{definitions_with_unknown_seals.length} building definitions with unknown seal references"
      else
        console.log " [OK] all building definitions have valid seal references"

      process.stdout.write '\n'

      simulation_definitions_with_unknown_resources = _.filter(simulation_definitions, (definition) ->
        _.find(_.union(definition.required_inputs, definition.optional_inputs, definition.storage, definition.outputs),
          (quantity) -> !audit_data.industry.resource_types_by_id[quantity.resource]?)?
      )
      if simulation_definitions_with_unknown_resources.length
        console.log " [ERROR] building simulation definition #{definition.id} has unknown resource type references" for definition in simulation_definitions_with_unknown_resources
        throw "found #{simulation_definitions_with_unknown_resources.length} building simulation definitions with unknown resource type references"
      else
        console.log " [OK] all building simulation definitions have valid resource type references"

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
