
path = require('path')
fs = require('fs')
_ = require('lodash')

AuditUtils = require('../utils/audit-utils')
FileUtils = require('../utils/file-utils')

{ CompanySeal } = require('@starpeace/starpeace-assets-types')


exports = module.exports = class AuditSeal
  @EXPECTED_COMPANY_SEAL_COUNT: 6

  @audit: (root_dir) -> (audit_data) -> new Promise (resolve, reject) ->
    try
      console.log " [OK] starting seal audit...\n"

      company_seals = FileUtils.parse_files(root_dir, ['.json'], [], CompanySeal.fromJson)
      company_seals_by_id = _.keyBy(company_seals, 'id')
      AuditUtils.audit_is_valid('company seal', company_seals)
      AuditUtils.audit_unique_count_by_id('company seal', company_seals, company_seals_by_id, AuditSeal.EXPECTED_COMPANY_SEAL_COUNT)

      console.log "\n [OK] finished seal audit successfully\n"
      console.log "-------------------------------------------------------------------------------\n"
      resolve(_.merge(audit_data, {
        seal: {
          company_seals_by_id
        }
      }))
    catch err
      reject(err)
