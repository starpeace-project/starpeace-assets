crypto = require('crypto')
fs = require('fs')
_ = require('lodash')
path = require('path')


exports = module.exports = class AuditUtils

  @audit_unique_count_by_id: (type_name, items, items_by_id, expected_count) ->
    unless items.length == _.size(items_by_id)
      for id,duplicate_items of _.groupBy(items, 'id')
        console.log " [ERROR] non-unique #{type_name} id: #{id}" if duplicate_items.length > 1
      throw "found non-unique #{type_name} id's"

    if items.length < expected_count
      console.log " [ERROR] found #{items.length} unique #{type_name}, expected at least #{expected_count}"
      throw "missing expected #{type_name} id's"
    else if items.length > expected_count
      console.log " [WARN] found #{items.length} unique #{type_name}, expected #{expected_count}; consider updating expected"
    else
      console.log " [OK] found #{items.length} unique #{type_name} (expected #{expected_count})"

  @audit_is_valid: (type_name, items) ->
    grouped_items = _.groupBy(items, (item) -> item.isValid())
    valid_items = grouped_items[true] || []
    invalid_items = grouped_items[false] || []
    if valid_items.length < items.length || invalid_items.length > 0
      console.log " [ERROR] #{type_name} is not valid: #{item.id}" for item in invalid_items
      throw "found #{invalid_items.length} invalid #{type_name} records"
    else
      console.log " [OK] found #{valid_items.length} valid #{type_name} records"
