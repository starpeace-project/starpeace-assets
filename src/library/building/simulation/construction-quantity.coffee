_ = require('lodash')

exports = module.exports = class ConstructionQuantity

  toJSON: () ->
    {
      resource: @resource
      quantity: @quantity,
      max_velocity: @max_velocity
    }

  is_valid: () ->
    return false unless _.isString(@resource) && @resource.length > 0
    return false unless _.isNumber(@quantity) && @quantity > 0
    return false unless _.isNumber(@max_velocity) && @max_velocity > 0
    true


  @from_json: (json) ->
    quantity = new ConstructionQuantity()
    quantity.resource = json.resource
    quantity.quantity = json.quantity
    quantity.max_velocity = json.max_velocity
    quantity
