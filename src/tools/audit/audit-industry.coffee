
path = require('path')
fs = require('fs')
_ = require('lodash')

AuditUtils = require('../utils/audit-utils')
FileUtils = require('../utils/file-utils')

{
  CityZone
  CompanySeal
  IndustryCategory
  IndustryType
  Level
  ResourceType
  ResourceUnit
} = require('../../lib')


exports = module.exports = class AuditIndustry
  @EXPECTED_CITY_ZONE_COUNT: 13
  @EXPECTED_INDUSTRY_CATEGORY_COUNT: 7
  @EXPECTED_INDUSTRY_TYPE_COUNT: 58
  @EXPECTED_LEVEL_COUNT: 6
  @EXPECTED_RESOURCE_TYPE_COUNT: 53
  @EXPECTED_RESOURCE_UNIT_COUNT: 10

  @audit: (root_dir) -> new Promise (resolve, reject) ->
    try
      console.log " [OK] starting industry audit...\n"

      city_zones = FileUtils.parse_files(root_dir, ['city-zones.json'], [], CityZone.from_json)
      city_zones_by_id = _.keyBy(city_zones, 'id')
      AuditUtils.audit_is_valid('city zone', city_zones)
      AuditUtils.audit_unique_count_by_id('city zone', city_zones, city_zones_by_id, AuditIndustry.EXPECTED_CITY_ZONE_COUNT)

      process.stdout.write '\n'

      industry_categories = FileUtils.parse_files(root_dir, ['industry-categories.json'], [], IndustryCategory.from_json)
      industry_categories_by_id = _.keyBy(industry_categories, 'id')
      AuditUtils.audit_is_valid('industry category', industry_categories)
      AuditUtils.audit_unique_count_by_id('industry category', industry_categories, industry_categories_by_id, AuditIndustry.EXPECTED_INDUSTRY_CATEGORY_COUNT)

      process.stdout.write '\n'

      industry_types = FileUtils.parse_files(root_dir, ['industry-types.json'], [], IndustryType.from_json)
      industry_types_by_id = _.keyBy(industry_types, 'id')
      AuditUtils.audit_is_valid('industry type', industry_types)
      AuditUtils.audit_unique_count_by_id('industry type', industry_types, industry_types_by_id, AuditIndustry.EXPECTED_INDUSTRY_TYPE_COUNT)

      process.stdout.write '\n'

      levels = FileUtils.parse_files(root_dir, ['levels.json'], [], Level.from_json)
      levels_by_id = _.keyBy(levels, 'id')
      AuditUtils.audit_is_valid('level', levels)
      AuditUtils.audit_unique_count_by_id('level', levels, levels_by_id, AuditIndustry.EXPECTED_LEVEL_COUNT)

      process.stdout.write '\n'

      resource_types = FileUtils.parse_files(root_dir, ['resource-types.json'], [], ResourceType.from_json)
      resource_types_by_id = _.keyBy(resource_types, 'id')
      AuditUtils.audit_is_valid('resource type', resource_types)
      AuditUtils.audit_unique_count_by_id('resource type', resource_types, resource_types_by_id, AuditIndustry.EXPECTED_RESOURCE_TYPE_COUNT)

      process.stdout.write '\n'

      resource_units = FileUtils.parse_files(root_dir, ['resource-units.json'], [], ResourceUnit.from_json)
      resource_units_by_id = _.keyBy(resource_units, 'id')
      AuditUtils.audit_is_valid('resource unit', resource_units)
      AuditUtils.audit_unique_count_by_id('resource unit', resource_units, resource_units_by_id, AuditIndustry.EXPECTED_RESOURCE_UNIT_COUNT)

      process.stdout.write '\n'

      resource_types_with_unknown_units = _.filter(resource_types, (type) -> !resource_units_by_id[type.unit_id]?)
      if resource_types_with_unknown_units.length
        console.log " [ERROR] resource type #{item.id} has unknown unit_id #{type.unit_id}" for type in resource_types_with_unknown_units
        throw "found #{resource_types_with_unknown_units.length} resource types with unknown unit references"
      else
        console.log " [OK] all resource types have valid resource unit references"

      console.log "\n [OK] finished industry audit successfully\n"
      console.log "-------------------------------------------------------------------------------\n"
      resolve({
        industry: {
          city_zones_by_id
          industry_categories_by_id
          industry_types_by_id
          levels_by_id
          resource_types_by_id
          resource_units_by_id
        }
      })
    catch err
      reject(err)
