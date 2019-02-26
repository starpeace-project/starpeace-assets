_ = require('lodash')

exports = module.exports = class ResourceQuantity

  toJSON: () ->
    {
      resource: @resource
      max_velocity: @max_velocity
      weight_efficiency: @weight_efficiency
      weight_quality: @weight_quality
    }

  is_valid: () ->
    return false unless _.isString(@resource) && @resource.length > 0
    return false unless _.isNumber(@max_velocity) && @max_velocity > 0
    return false unless _.isNumber(@weight_efficiency) && @weight_efficiency >= 0
    return false unless _.isNumber(@weight_quality) && @weight_quality >= 0
    true


  @from_json = (json) ->
    quantity = new ResourceQuantity()
    quantity.resource = json.resource
    quantity.max_velocity = json.max_velocity
    quantity.weight_efficiency = if json.weight_efficiency? then json.weight_efficiency else 0
    quantity.weight_quality = if json.weight_quality? then json.weight_quality else 0
    quantity
