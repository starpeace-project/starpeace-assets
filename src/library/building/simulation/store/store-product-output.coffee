_ = require('lodash')

StoreProductCustomer = require('./store-product-customer')

exports = module.exports = class StoreProductOutput

  toJSON: () ->
    {
      resource: @resource
      max_velocity: @max_velocity
      customers: @customers
    }

  is_valid: () ->
    return false unless _.isString(@resource) && @resource.length > 0
    return false unless _.isNumber(@max_velocity) && @max_velocity > 0
    return false unless Array.isArray(@customers)
    return false if @customers.length && _.find(@customers, (item) -> !item.is_valid())?
    true


  @from_json: (json) ->
    output = new StoreProductOutput()
    output.resource = json.resource
    output.max_velocity = json.max_velocity
    output.customers = _.map(json.customers, StoreProductCustomer.from_json)
    output
