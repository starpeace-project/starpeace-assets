_ = require('lodash')

ResourceQuantity = require('../../industry/resource-quantity')

exports = module.exports = class FactoryStage

  toJSON: () ->
    {
      index: @index
      duration: @duration
      stage_inputs: @stage_inputs
      labor: @labor
      operations: @operations
      inputs: @inputs
      outputs: @outputs
    }

  is_valid: () ->
    return false unless _.isNumber(@index) && @index > 0
    return false unless _.isNumber(@duration) && @duration > 0

    # FIXME: TODO: validate stage_inputs

    return false unless Array.isArray(@labor) && @labor?.length > 0
    return false if _.find(@labor, (item) -> !item.is_valid())?
    return false unless Array.isArray(@operations)
    return false if @operations.length && _.find(@operations, (item) -> !item.is_valid())?
    return false unless Array.isArray(@inputs)
    return false if @inputs.length && _.find(@inputs, (item) -> !item.is_valid())?
    return false unless Array.isArray(@outputs)
    return false if @outputs.length && _.find(@outputs, (item) -> !item.is_valid())?
    true


  @from_json: (json) ->
    stage = new FactoryStage()
    stage.index = json.index
    stage.duration = json.duration
    stage.stage_inputs = json.stage_inputs
    stage.labor = _.map(json.labor, ResourceQuantity.from_json)
    stage.operations = _.map(json.operations, ResourceQuantity.from_json)
    stage.inputs = _.map(json.inputs, ResourceQuantity.from_json)
    stage.outputs = _.map(json.outputs, ResourceQuantity.from_json)
    stage
