_ = require('lodash')

SimulationDefinition = require('../simulation-definition')
ResourceQuantity = require('../../../industry/resource-quantity')

exports = module.exports = class StorageDefinition extends SimulationDefinition

  toJSON: () ->
    _.assign(super.toJSON(), {
      labor: @labor
      operations: @operations
      storage: @storage
    })

  is_valid: () ->
    return false unless super.is_valid()
    return false unless Array.isArray(@labor) && @labor?.length > 0
    return false if _.find(@labor, (item) -> !item.is_valid())?
    return false unless Array.isArray(@operations)
    return false if @operations.length && _.find(@operations, (item) -> !item.is_valid())?

    # FIXME: TODO: storage validation
    # return false unless  Array.isArray(@stages) && @storage?.length > 0
    # return false if _.find(@storage, (item) -> !item.is_valid())?
    true


  @from_json: (json) ->
    definition = new StorageDefinition()
    definition.labor = _.map(json.labor, ResourceQuantity.from_json)
    definition.operations = _.map(json.operations, ResourceQuantity.from_json)
    definition.storage = json.storage
    definition
