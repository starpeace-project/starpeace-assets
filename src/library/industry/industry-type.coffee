_ = require('lodash')

exports = module.exports = class IndustryType

  toJSON: () ->
    {
      id: @id
      label: @label
    }

  is_valid: () ->
    return false unless _.isString(@id) && @id.length > 0
    return false unless @label?
    true


  @from_json = (json) ->
    type = new IndustryType()
    type.id = json.id
    type.label = json.label
    type
