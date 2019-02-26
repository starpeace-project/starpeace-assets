_ = require('lodash')

ResourceQuantity = require('../../industry/resource-quantity')
StoreProductOutput = require('./store-product-output')

exports = module.exports = class StoreProduct

  toJSON: () ->
    {
      inputs: @inputs
      outputs: @outputs
    }

  is_valid: () ->
    return false unless Array.isArray(@inputs)
    return false if @inputs.length && _.find(@inputs, (item) -> !item.is_valid())?
    return false unless Array.isArray(@outputs)
    return false if @outputs.length && _.find(@outputs, (item) -> !item.is_valid())?
    true


  @from_json: (json) ->
    stage = new StoreProduct()
    stage.inputs = _.map(json.inputs, ResourceQuantity.from_json)
    stage.outputs = _.map(json.outputs, StoreProductOutput.from_json)
    stage
