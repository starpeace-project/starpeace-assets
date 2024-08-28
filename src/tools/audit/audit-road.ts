import _ from 'lodash';
import fs from 'fs';
import { RoadDefinition, RoadImageDefinition } from '@starpeace/starpeace-assets-types';

import FileUtils from '../utils/file-utils.js';
import AuditUtils from '../utils/audit-utils.js';


export default class AuditRoad {
  static EXPECTED_DEFINITION_COUNT = 2;
  static EXPECTED_IMAGE_DEFINITION_COUNT = 73;

  static audit (rootRoadDir: string, rootTrackDir: string, auditData: any): any {
    console.log(" [OK] starting road audit...\n");

    const roadDefinitions: RoadDefinition[] = FileUtils.parseFiles(rootRoadDir, ['.json'], ['-image.json'], RoadDefinition.fromJson);
    const trackDefinitions: RoadDefinition[] = FileUtils.parseFiles(rootTrackDir, ['.json'], ['-image.json'], RoadDefinition.fromJson);
    const definitions = [...roadDefinitions, ...trackDefinitions];
    const definitionsById: Record<string, RoadDefinition> = _.keyBy(definitions, 'id');
    AuditUtils.auditIsValid('road definition', definitions);
    AuditUtils.auditUniqueCountById('road definition', definitions, definitionsById, AuditRoad.EXPECTED_DEFINITION_COUNT);

    process.stdout.write('\n');

    const roadImageDefinitions = FileUtils.parseFiles(rootRoadDir, ['-image.json'], [], RoadImageDefinition.fromJson);
    const trackImageDefinitions = FileUtils.parseFiles(rootTrackDir, ['-image.json'], [], RoadImageDefinition.fromJson);
    const imageDefinitions = [...roadImageDefinitions, ...trackImageDefinitions];
    const imageDefinitionsById = _.keyBy(imageDefinitions, 'id');
    AuditUtils.auditIsValid('road image definition', imageDefinitions);
    AuditUtils.auditUniqueCountById('road image definition', imageDefinitions, imageDefinitionsById, AuditRoad.EXPECTED_IMAGE_DEFINITION_COUNT);

    for (const definition of imageDefinitions) {
      if (!fs.existsSync(definition.imagePath)) {
        throw `Unable to find road image ${definition.imagePath}`;
      }
    }


    process.stdout.write('\n');

    for (const definition of definitions) {
      const withUnknownImages = Object.values(definition.imageCatalog).flatMap(Object.values).filter((id) => !imageDefinitionsById[id]);
      if (withUnknownImages.length) {
        for (const imageId of withUnknownImages) {
          console.log(` [ERROR] road definition ${definition.id} has unknown image reference ${imageId}`);
        }
        throw `found ${withUnknownImages.length} road definitions with unknown imageId references`;
      }
    }
    console.log(" [OK] all road definitions have valid imageId references");

    process.stdout.write('\n');

    console.log("\n [OK] finished road audit successfully\n");
    console.log("-------------------------------------------------------------------------------\n");
    return _.merge(auditData, {
      road: {
        definitionsById,
        imageDefinitionsById
      }
    });
  }
}
