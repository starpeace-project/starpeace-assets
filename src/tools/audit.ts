import path from 'path';

import AuditBuilding from './audit/audit-building.js';
import AuditIndustry from './audit/audit-industry.js';
import AuditInvention from './audit/audit-invention.js';
import AuditRoad from './audit/audit-road.js';
import AuditSeal from './audit/audit-seal.js';

class Audit {
  root: string;
  source_dir: string;

  constructor () {
    this.root = process.cwd();
    this.source_dir = path.join(this.root, process.argv[2]);
  }

  showConfiguration (): void {
    console.log(` input directory: ${this.source_dir}`);
    console.log("\n-------------------------------------------------------------------------------\n");
  }

  async audit (): Promise<void> {
    try {
      let auditData = {};

      auditData = AuditIndustry.audit(path.join(this.source_dir, 'industry'));
      auditData = AuditInvention.audit(path.join(this.source_dir, 'inventions'), auditData);
      auditData = AuditSeal.audit(path.join(this.source_dir, 'seals'), auditData);
      auditData = AuditBuilding.audit(path.join(this.source_dir, 'buildings'), auditData);
      auditData = AuditRoad.audit(path.join(this.source_dir, 'roads'), auditData);

      console.log(" [DONE] finished STARPEACE audit successfully!");
    }
    catch (err) {
      console.log("\n-------------------------------------------------------------------------------\n");
      console.log(err);
      console.log(` [ERROR] encountered problems during STARPEACE audit: ${err}\n`);
      process.exit(1);
    }
  }

  static showBanner (): void {
    console.log("\n===============================================================================\n");
    console.log(" audit.js - https://www.starpeace.io\n");
    console.log(" analyze and audit gameplay configurations and related assets, identifying");
    console.log(" missing, superfluous, or resources with problems.\n");
    console.log(" see README.md for more details");
    console.log("\n===============================================================================\n");
  }
}

Promise.resolve(new Audit().audit());
