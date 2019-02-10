path = require('path')
fs = require('fs')
_ = require('lodash')

AuditBuilding = require('./audit/audit-building')
AuditIndustry = require('./audit/audit-industry')

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

console.log " input directory: #{source_dir}"
console.log " building root directory: #{building_root_dir}"
console.log " industry root directory: #{industry_root_dir}"
console.log "\n-------------------------------------------------------------------------------\n"

Promise.resolve AuditIndustry.audit(industry_root_dir)
  .then AuditBuilding.audit(building_root_dir)
  .then (audit_data) ->

    console.log " [DONE] finished STARPEACE audit successfully!"

  .catch (err) ->
    console.log "\n-------------------------------------------------------------------------------\n"
    console.log " [ERROR] encountered problems during STARPEACE audit: #{err}\n"
    process.exit(1)
