import path from 'path';
import AuditIndustry from './audit/audit-industry.js';
import AuditInvention from './audit/audit-invention.js';
import AuditSeal from './audit/audit-seal.js';
import AuditBuilding from './audit/audit-building.js';

class Audit {
  root: string;
  source_dir: string;

  building_root_dir: string;
  industry_root_dir: string;
  invention_root_dir: string;
  seal_root_dir: string;

  constructor () {
    this.root = process.cwd();
    this.source_dir = path.join(this.root, process.argv[2]);

    this.building_root_dir = path.join(this.source_dir, 'buildings');
    this.industry_root_dir = path.join(this.source_dir, 'industry');
    this.invention_root_dir = path.join(this.source_dir, 'inventions');
    this.seal_root_dir = path.join(this.source_dir, 'seals');
  }

  showConfiguration (): void {
    console.log(` input directory: ${this.source_dir}`);
    console.log(` building root directory: ${this.building_root_dir}`);
    console.log(` industry root directory: ${this.industry_root_dir}`);
    console.log(` invention root directory: ${this.invention_root_dir}`);
    console.log(` seal root directory: ${this.seal_root_dir}`);
    console.log("\n-------------------------------------------------------------------------------\n");
  }

  async audit (): Promise<void> {
    try {
      let auditData = {};

      auditData = AuditIndustry.audit(this.industry_root_dir);
      auditData = AuditInvention.audit(this.invention_root_dir, auditData);
      auditData = AuditSeal.audit(this.seal_root_dir, auditData);
      auditData = AuditBuilding.audit(this.building_root_dir, auditData);

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
