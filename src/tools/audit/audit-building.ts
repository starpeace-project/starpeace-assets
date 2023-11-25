import _ from 'lodash';
import { BuildingDefinition, BuildingImageDefinition, SimulationDefinitionParser } from '@starpeace/starpeace-assets-types';

import FileUtils from '../utils/file-utils.js';
import AuditUtils from '../utils/audit-utils.js';



export default class AuditBuilding {
  static EXPECTED_DEFINITION_COUNT = 321;
  static EXPECTED_IMAGE_DEFINITION_COUNT = 412;
  static EXPECTED_SIMULATION_DEFINITION_COUNT = 321;

  static audit (rootDir: string, auditData: any): any {
    console.log(" [OK] starting building audit...\n");

    const definitions = FileUtils.parseFiles(rootDir, ['.json'], ['-simulation.json', '-image.json'], BuildingDefinition.fromJson);
    const definitions_by_id = _.keyBy(definitions, 'id');
    AuditUtils.auditIsValid('building definition', definitions);
    AuditUtils.auditUniqueCountById('building definition', definitions, definitions_by_id, AuditBuilding.EXPECTED_DEFINITION_COUNT);

    process.stdout.write('\n');

    const image_definitions = FileUtils.parseFiles(rootDir, ['-image.json'], [], BuildingImageDefinition.fromJson);
    const image_definitions_by_id = _.keyBy(image_definitions, 'id');
    AuditUtils.auditIsValid('building image definition', image_definitions);
    AuditUtils.auditUniqueCountById('building image definition', image_definitions, image_definitions_by_id, AuditBuilding.EXPECTED_IMAGE_DEFINITION_COUNT);

    process.stdout.write('\n');

    const simulation_definitions = FileUtils.parseFiles(rootDir, ['-simulation.json'], [], SimulationDefinitionParser.fromJson);
    const simulation_definitions_by_id = _.keyBy(simulation_definitions, 'id');
    AuditUtils.auditIsValid('building simulation definition', simulation_definitions);
    AuditUtils.auditUniqueCountById('building simulation definition', simulation_definitions, simulation_definitions_by_id, AuditBuilding.EXPECTED_SIMULATION_DEFINITION_COUNT);

    process.stdout.write('\n');

    const definitions_with_unknown_simulation_definitions = definitions.filter((definition) => !simulation_definitions_by_id[definition.id]);
    if (definitions_with_unknown_simulation_definitions.length) {
      for (const definition of definitions_with_unknown_simulation_definitions) {
        console.log(` [WARN] building definition ${definition.id} has unknown definition reference`);
      }
    }
    else {
      console.log(" [OK] all building definitions have valid simulation definition references");
    }

    process.stdout.write('\n');

    const definitions_with_unknown_images = definitions.filter((definition) => !image_definitions_by_id[definition.imageId] || !image_definitions_by_id[definition.constructionImageId]);
    if (definitions_with_unknown_images.length) {
      for (const definition of definitions_with_unknown_images) {
        console.log(` [ERROR] building definition ${definition.id} has unknown image references ${definition.imageId} or ${definition.constructionImageId}`);
      }
      throw `found ${definitions_with_unknown_images.length} building definitions with unknown imageId or constructionImageId references`;
    }
    else {
      console.log(" [OK] all building definitions have valid imageId and constructionImageId references");
    }

    const definitions_with_unknown_zones = definitions.filter((definition) => !auditData.industry.city_zones_by_id[definition.zoneId]);
    if (definitions_with_unknown_zones.length) {
      for (const definition of definitions_with_unknown_zones) {
        console.log(` [ERROR] building definition ${definition.id} has unknown city zone references ${definition.zoneId}`);
      }
      throw `found ${definitions_with_unknown_zones.length} building definitions with unknown city zone references`;
    }
    else {
      console.log(" [OK] all building definitions have valid city zone references");
    }

    const definitions_with_unknown_categories = definitions.filter((definition) => !auditData.industry.industry_categories_by_id[definition.industryCategoryId])
    if (definitions_with_unknown_categories.length) {
      for (const definition of definitions_with_unknown_categories) {
        console.log(` [ERROR] building definition ${definition.id} has unknown category references ${definition.industryCategoryId}`);
      }
      throw `found ${definitions_with_unknown_categories.length} building definitions with unknown industry category references`;
    }
    else {
      console.log(" [OK] all building definitions have valid industry category references");
    }

    const definitions_with_unknown_types = definitions.filter((definition) => !auditData.industry.industry_types_by_id[definition.industryTypeId]);
    if (definitions_with_unknown_types.length) {
      for (const definition of definitions_with_unknown_types) {
        console.log(` [ERROR] building definition ${definition.id} has unknown industry type references ${definition.industryTypeId}`);
      }
      throw `found ${definitions_with_unknown_types.length} building definitions with unknown industry type references`;
    }
    else {
      console.log(" [OK] all building definitions have valid industry type references");
    }

    const definitions_with_unknown_seals = definitions.filter((definition) => !auditData.seal.company_seals_by_id[definition.sealId]);
    if (definitions_with_unknown_seals.length) {
      for (const definition of definitions_with_unknown_seals) {
        console.log(` [ERROR] building definition ${definition.id} has unknown seal references ${definition.sealId}`);
      }
      throw `found ${definitions_with_unknown_seals.length} building definitions with unknown seal references`;
    }
    else {
      console.log(" [OK] all building definitions have valid seal references");
    }

    process.stdout.write('\n');

    const simulation_definitions_with_unknown_definitions = simulation_definitions.filter((definition) => !definitions_by_id[definition.id]);
    if (simulation_definitions_with_unknown_definitions.length) {
      for (const definition of simulation_definitions_with_unknown_definitions) {
        console.log(` [ERROR] building simulation definition ${definition.id} has unknown definition reference`);
      }
      throw `found ${simulation_definitions_with_unknown_definitions.length} building simulation definitions with unknown definition references`;
    }
    else {
      console.log(" [OK] all building simulation definitions have valid definition references");
    }

    const definitions_with_unknown_inventions = definitions.filter((definition) => definition.requiredInventionIds.length && !!definition.requiredInventionIds.find((id: string) => !auditData.invention.definitions_by_id[id]));
    if (definitions_with_unknown_inventions.length) {
      for (const definition of definitions_with_unknown_inventions) {
        console.log(` [ERROR] building definition ${definition.id} has unknown required invention references`);
      }
      throw `found ${definitions_with_unknown_inventions.length} building definitions with unknown required invention references`;
    }
    else {
      console.log(" [OK] all building definitions have valid required invention references");
    }

    console.log("\n [OK] finished building audit successfully\n");
    console.log("-------------------------------------------------------------------------------\n");
    return _.merge(auditData, {
      building: {
        definitions_by_id,
        image_definitions_by_id,
        simulation_definitions_by_id
      }
    });
  }
}
