import _ from 'lodash';
import { TerrainDefinition } from '@starpeace/starpeace-assets-types';

import FileUtils from '../utils/file-utils.js';
import AuditUtils from '../utils/audit-utils.js';


export default class AuditTerrain {
  static EXPECTED_TERRAIN_COUNT = 161;

  static audit (rootDir: string, auditData: any): any {
    console.log(" [OK] starting terrain audit...\n");

    const terrains = FileUtils.parseFiles(rootDir, ['.json'], ['tree-manifest.json'], TerrainDefinition.fromJson);
    const terrainById = new Map(terrains.map(t => [t.id, t]));
    const terrainByColor = new Map();

    for (const terrain of terrains) {
      if (!terrainByColor.get(terrain.color)) {
        terrainByColor.set(terrain.color, []);
      }
      terrainByColor.get(terrain.color).push(terrain);
    }

    AuditUtils.auditIsValid('terrain', terrains);
    AuditUtils.auditUniqueCountById('terrain', terrains, terrainById, AuditTerrain.EXPECTED_TERRAIN_COUNT);

    if (terrainByColor.size != terrainById.size) {
      console.log("");
      for (const [color, terrains] of terrainByColor.entries()) {
        if (terrains.length > 1) {
          console.log(` [WARN] duplicate terrain color: ${color}`);
        }
      }
    }

    console.log("\n [OK] finished terrain audit successfully\n")
    console.log("-------------------------------------------------------------------------------\n");

    return _.merge(auditData, {
      terrain: {
        terrainById
      }
    });
  }
}
