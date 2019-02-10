_ = require('lodash')

exports = module.exports = class ResourceUnit

  toJSON: () ->
    {
      id: @id
      label_plural: @label_plural
    }

  is_valid: () ->
    return false unless _.isString(@id) && @id.length > 0
    return false unless @label_plural?
    true


  @from_json = (json) ->
    unit = new ResourceUnit()
    unit.id = json.id
    unit.label_plural = json.label_plural
    unit
