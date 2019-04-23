_ = require('lodash')

SimulationDefinition = require('../simulation-definition')
ResourceQuantity = require('../../../industry/resource-quantity')

exports = module.exports = class OfficeDefinition extends SimulationDefinition

  toJSON: () ->
    _.assign(super.toJSON(), {
      labor: @labor
      efficiency: @efficiency
      capacity: @capacity
    })

  is_valid: () ->
    return false unless super.is_valid()
    return false unless Array.isArray(@labor) && @labor?.length > 0
    return false if _.find(@labor, (item) -> !item.is_valid())?

    return false unless _.isNumber(@efficiency) && @efficiency > 0 && @efficiency <= 1.0
    return false unless _.isNumber(@capacity) && @capacity > 0

    true


  @from_json: (json) ->
    definition = new OfficeDefinition()
    definition.labor = _.map(json.labor, ResourceQuantity.from_json)
    definition.efficiency = json.efficiency
    definition.capacity = json.capacity
    definition
