_ = require('lodash')

exports = module.exports = class IndustryCategory

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
    category = new IndustryCategory()
    category.id = json.id
    category.label = json.label
    category
