import _ from 'lodash';
import { InventionDefinition } from '@starpeace/starpeace-assets-types';

import FileUtils from '../utils/file-utils.js';
import AuditUtils from '../utils/audit-utils.js';


export default class AuditInvention {
  static EXPECTED_INVENTION_COUNT = 882;

  static audit (rootDir: string, auditData: any): any {
    console.log(" [OK] starting invention audit...\n");

    const definitions = FileUtils.parseFiles(rootDir, ['.json'], [], InventionDefinition.fromJson);
    const definitions_by_id = _.keyBy(definitions, 'id');
    AuditUtils.auditIsValid('invention definition', definitions);
    AuditUtils.auditUniqueCountById('invention definition', definitions, definitions_by_id, AuditInvention.EXPECTED_INVENTION_COUNT);

    process.stdout.write('\n');

    const definitions_with_unknown_categories = definitions.filter((definition) => !auditData.industry.industry_categories_by_id[definition.industryCategoryId]);
    if (definitions_with_unknown_categories.length) {
      for (const definition of definitions_with_unknown_categories) {
        console.log(` [ERROR] invention definition ${definition.id} has unknown category references ${definition.industryCategoryId}`);
      }
      throw `found ${definitions_with_unknown_categories.length} invention definitions with unknown industry category references`;
    }
    else {
      console.log(" [OK] all invention definitions have valid industry category references");
    }

    const definitions_with_unknown_types = definitions.filter((definition) => !auditData.industry.industry_types_by_id[definition.industryTypeId])
    if (definitions_with_unknown_types.length) {
      for (const definition of definitions_with_unknown_types) {
        console.log(` [ERROR] invention definition ${definition.id} has unknown industry type references ${definition.industryTypeId}`);
      }
      throw `found ${definitions_with_unknown_types.length} invention definitions with unknown industry type references`;
    }
    else {
      console.log(" [OK] all invention definitions have valid industry type references");
    }

    const definitions_with_unknown_dependencies = definitions.filter((definition) => !!definition.dependsOnIds.find((dependId: string) => !definitions_by_id[dependId]));
    if (definitions_with_unknown_dependencies.length) {
      for (const definition of definitions_with_unknown_dependencies) {
        console.log(` [ERROR] invention definition ${definition.id} has unknown dependency reference ${definition.dependsOnIds}`);
      }
      throw `found ${definitions_with_unknown_dependencies.length} invention definitions with unknown dependsOnIds references`;
    }
    else {
      console.log(" [OK] all invention definitions have valid dependsOnIds references");
    }

    const definitions_with_unknown_property_level = definitions.filter((definition) => !!definition.properties.levelId && !auditData.industry.levels_by_id[definition.properties.levelId]);
    if (definitions_with_unknown_property_level.length) {
      for (const definition of definitions_with_unknown_property_level) {
        console.log(` [ERROR] invention definition ${definition.id} has unknown level references ${definition.properties.levelId}`);
      }
      throw `found ${definitions_with_unknown_property_level.length} invention definitions with unknown level references`;
    }
    else {
      console.log(" [OK] all invention definitions have valid level references");
    }

    console.log("\n [OK] finished invention audit successfully\n");
    console.log("-------------------------------------------------------------------------------\n");
    return _.merge(auditData, {
      invention: {
        definitions_by_id
      }
    });
  }
}
