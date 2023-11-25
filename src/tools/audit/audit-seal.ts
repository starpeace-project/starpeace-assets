import _ from 'lodash';
import { CompanySeal } from '@starpeace/starpeace-assets-types';

import FileUtils from '../utils/file-utils.js';
import AuditUtils from '../utils/audit-utils.js';


export default class AuditSeal {
  static EXPECTED_COMPANY_SEAL_COUNT = 6;

  static audit (rootDir: string, auditData: any): any {
    console.log(" [OK] starting seal audit...\n");

    const company_seals = FileUtils.parseFiles(rootDir, ['.json'], [], CompanySeal.fromJson);
    const company_seals_by_id = _.keyBy(company_seals, 'id');

    AuditUtils.auditIsValid('company seal', company_seals);
    AuditUtils.auditUniqueCountById('company seal', company_seals, company_seals_by_id, AuditSeal.EXPECTED_COMPANY_SEAL_COUNT);

    console.log("\n [OK] finished seal audit successfully\n")
    console.log("-------------------------------------------------------------------------------\n");

    return _.merge(auditData, {
      seal: {
        company_seals_by_id
      }
    });
  }
}
