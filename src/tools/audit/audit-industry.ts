import _ from 'lodash';

import { CityZone, IndustryCategory, IndustryType, Level, ResourceType, ResourceUnit } from '@starpeace/starpeace-assets-types'

import FileUtils from '../utils/file-utils.js';
import AuditUtils from '../utils/audit-utils.js';


export default class AuditIndustry {
  static EXPECTED_CITY_ZONE_COUNT = 12;
  static EXPECTED_INDUSTRY_CATEGORY_COUNT = 8;
  static EXPECTED_INDUSTRY_TYPE_COUNT = 62;
  static EXPECTED_LEVEL_COUNT = 6;
  static EXPECTED_RESOURCE_TYPE_COUNT = 55;
  static EXPECTED_RESOURCE_UNIT_COUNT = 10;

  static audit (rootDir: string): any {
    console.log(" [OK] starting industry audit...\n");

    const city_zones = FileUtils.parseFiles(rootDir, ['city-zones.json'], [], CityZone.fromJson)
    const city_zones_by_id = _.keyBy(city_zones, 'id');
    AuditUtils.auditIsValid('city zone', city_zones);
    AuditUtils.auditUniqueCountById('city zone', city_zones, city_zones_by_id, AuditIndustry.EXPECTED_CITY_ZONE_COUNT);

    process.stdout.write('\n');

    const industry_categories = FileUtils.parseFiles(rootDir, ['industry-categories.json'], [], IndustryCategory.fromJson);
    const industry_categories_by_id = _.keyBy(industry_categories, 'id');
    AuditUtils.auditIsValid('industry category', industry_categories);
    AuditUtils.auditUniqueCountById('industry category', industry_categories, industry_categories_by_id, AuditIndustry.EXPECTED_INDUSTRY_CATEGORY_COUNT);

    process.stdout.write('\n');

    const industry_types = FileUtils.parseFiles(rootDir, ['industry-types.json'], [], IndustryType.fromJson);
    const industry_types_by_id = _.keyBy(industry_types, 'id');
    AuditUtils.auditIsValid('industry type', industry_types);
    AuditUtils.auditUniqueCountById('industry type', industry_types, industry_types_by_id, AuditIndustry.EXPECTED_INDUSTRY_TYPE_COUNT);

    process.stdout.write('\n');

    const levels = FileUtils.parseFiles(rootDir, ['levels.json'], [], Level.fromJson);
    const levels_by_id = _.keyBy(levels, 'id');
    AuditUtils.auditIsValid('level', levels);
    AuditUtils.auditUniqueCountById('level', levels, levels_by_id, AuditIndustry.EXPECTED_LEVEL_COUNT);

    process.stdout.write('\n');

    const resource_types = FileUtils.parseFiles(rootDir, ['resource-types.json'], [], ResourceType.fromJson);
    const resource_types_by_id = _.keyBy(resource_types, 'id');
    AuditUtils.auditIsValid('resource type', resource_types);
    AuditUtils.auditUniqueCountById('resource type', resource_types, resource_types_by_id, AuditIndustry.EXPECTED_RESOURCE_TYPE_COUNT);

    process.stdout.write('\n');

    const resource_units = FileUtils.parseFiles(rootDir, ['resource-units.json'], [], ResourceUnit.fromJson);
    const resource_units_by_id = _.keyBy(resource_units, 'id');
    AuditUtils.auditIsValid('resource unit', resource_units);
    AuditUtils.auditUniqueCountById('resource unit', resource_units, resource_units_by_id, AuditIndustry.EXPECTED_RESOURCE_UNIT_COUNT);

    process.stdout.write('\n');

    const resource_types_with_unknown_units = resource_types.filter((type) => !resource_units_by_id[type.unitId]);
    if (resource_types_with_unknown_units.length) {
      for (const type of resource_types_with_unknown_units) {
        console.log(` [ERROR] resource type ${type.id} has unknown unitId ${type.unitId}`);
      }
      throw `found ${resource_types_with_unknown_units.length} resource types with unknown unit references`;
    }
    else {
      console.log(" [OK] all resource types have valid resource unit references");
    }

    console.log("\n [OK] finished industry audit successfully\n");
    console.log("-------------------------------------------------------------------------------\n");
    return {
      industry: {
        city_zones_by_id,
        industry_categories_by_id,
        industry_types_by_id,
        levels_by_id,
        resource_types_by_id,
        resource_units_by_id
      }
    };
  }
}
