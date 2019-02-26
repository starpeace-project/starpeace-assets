_ = require('lodash')

SimulationDefinition = require('./simulation-definition')
StoreProduct = require('./store-product')
ResourceQuantity = require('../../industry/resource-quantity')

exports = module.exports = class StoreDefinition extends SimulationDefinition

  toJSON: () ->
    _.assign(super.toJSON(), {
      labor: @labor
      operations: @operations
      products: @products
    })

  is_valid: () ->
    return false unless super.is_valid()
    return false unless Array.isArray(@labor) && @labor?.length > 0
    return false if _.find(@labor, (item) -> !item.is_valid())?
    return false unless Array.isArray(@operations)
    return false if @operations.length && _.find(@operations, (item) -> !item.is_valid())?
    return false unless Array.isArray(@products) && @products?.length > 0
    return false if _.find(@products, (item) -> !item.is_valid())?
    true


  @from_json: (json) ->
    definition = new StoreDefinition()
    definition.labor = _.map(json.labor, ResourceQuantity.from_json)
    definition.operations = _.map(json.operations, ResourceQuantity.from_json)
    definition.products = _.map(json.products, StoreProduct.from_json)
    definition
