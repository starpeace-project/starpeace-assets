_ = require('lodash')

ResourceQuantity = require('../../industry/resource-quantity')

exports = module.exports = class StoreProductCustomer

  toJSON: () ->
    {
      resource: @resource
      max_velocity: @max_velocity
      probability: @probability
    }


  is_valid: () ->
    return false unless _.isString(@resource) && @resource.length > 0
    return false unless _.isNumber(@max_velocity) && @max_velocity > 0
    return false unless _.isNumber(@probability) && @probability > 0
    true


  @from_json: (json) ->
    customer = new StoreProductCustomer()
    customer.resource = json.resource
    customer.max_velocity = json.max_velocity
    customer.probability = json.probability
    customer
