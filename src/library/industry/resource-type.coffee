_ = require('lodash')

exports = module.exports = class ResourceType

  toJSON: () ->
    {
      id: @id
      label_plural: @label_plural
      unit_id: @unit_id
      price: @price
    }

  is_valid: () ->
    return false unless _.isString(@id) && @id.length > 0
    return false unless @label_plural?
    return false unless _.isString(@unit_id) && @unit_id.length > 0
    return false unless _.isNumber(@price) && @price > 0
    true


  @from_json = (json) ->
    type = new ResourceType()
    type.id = json.id
    type.label_plural = json.label_plural
    type.unit_id = json.unit_id
    type.price = json.price
    type
