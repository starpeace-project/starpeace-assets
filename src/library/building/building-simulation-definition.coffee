_ = require('lodash')

ResourceQuantity = require('../industry/resource-quantity')

exports = module.exports = class BuildingSimulationDefinition

  toJSON: () ->
    json = {
      id: @id
      type: @type
      cost: @cost
    }

    json.budget = @budget if _.isNumber(@budget)
    json.required_inputs = @required_inputs if _.isArray(@required_inputs) && @required_inputs.length
    json.optional_inputs = @optional_inputs if _.isArray(@optional_inputs) && @optional_inputs.length
    json.storage = @storage if _.isArray(@storage) && @storage.length
    json.outputs = @outputs if _.isArray(@outputs) && @outputs.length

    json

  is_valid: () ->
    return false unless _.isString(@id) && @id.length > 0

    is_industry = @type == 'INDUSTRY';
    is_warehouse = @type == 'WAREHOUSE';

    return false unless is_industry || is_warehouse
    return false unless _.isNumber(@cost) && @cost > 0

    true


  @from_json: (json) ->
    definition = new BuildingSimulationDefinition()
    definition.id = json.id
    definition.type = json.type
    definition.cost = json.cost
    definition.budget = json.budget
    definition.required_inputs = _.map(json.required_inputs, ResourceQuantity.from_json)
    definition.optional_inputs = _.map(json.optional_inputs, ResourceQuantity.from_json)
    definition.storage = _.map(json.storage, ResourceQuantity.from_json)
    definition.outputs = _.map(json.outputs, ResourceQuantity.from_json)
    definition
