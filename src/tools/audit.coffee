path = require('path')
fs = require('fs')
_ = require('lodash')

AuditBuilding = require('./audit/audit-building')
AuditIndustry = require('./audit/audit-industry')
AuditInvention = require('./audit/audit-invention')
AuditSeal = require('./audit/audit-seal')

FileUtils = require('./utils/file-utils')
Utils = require('./utils/utils')


console.log "\n===============================================================================\n"
console.log " audit.js - https://www.starpeace.io\n"
console.log " analyze and audit gameplay configurations and related assets, identifying"
console.log " missing, superfluous, or resources with problems.\n"
console.log " see README.md for more details"
console.log "\n===============================================================================\n"

root = process.cwd()
source_dir = path.join(root, process.argv[2])

building_root_dir = path.join(source_dir, 'buildings')
industry_root_dir = path.join(source_dir, 'industry')
invention_root_dir = path.join(source_dir, 'inventions')
seal_root_dir = path.join(source_dir, 'seals')

console.log " input directory: #{source_dir}"
console.log " building root directory: #{building_root_dir}"
console.log " industry root directory: #{industry_root_dir}"
console.log " invention root directory: #{invention_root_dir}"
console.log " seal root directory: #{seal_root_dir}"
console.log "\n-------------------------------------------------------------------------------\n"

Promise.resolve AuditIndustry.audit(industry_root_dir)
  .then AuditInvention.audit(invention_root_dir)
  .then AuditSeal.audit(seal_root_dir)
  .then AuditBuilding.audit(building_root_dir)
  .then (audit_data) ->

    console.log " [DONE] finished STARPEACE audit successfully!"

  .catch (err) ->
    console.log "\n-------------------------------------------------------------------------------\n"
    console.log err
    console.log " [ERROR] encountered problems during STARPEACE audit: #{err}\n"
    process.exit(1)
