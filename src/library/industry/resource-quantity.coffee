_ = require('lodash')

exports = module.exports = class ResourceQuantity

  toJSON: () ->
    {
      resource: @resource
      max: @max
    }

  is_valid: () ->
    return false unless _.isString(@resource) && @resource.length > 0
    return false unless _.isNumber(@max) && @max > 0
    true


  @from_json = (json) ->
    quantity = new ResourceQuantity()
    quantity.resource = json.resource
    quantity.max = json.max
    quantity
