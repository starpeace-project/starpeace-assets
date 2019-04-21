_ = require('lodash')

SimulationDefinition = require('../simulation-definition')
ResourceQuantity = require('../../../industry/resource-quantity')

exports = module.exports = class AntennaDefinition extends SimulationDefinition

  toJSON: () ->
    _.assign(super.toJSON(), {
      labor: @labor
      range: @range
    })

  is_valid: () ->
    return false unless super.is_valid()
    return false unless Array.isArray(@labor) && @labor?.length > 0
    return false if _.find(@labor, (item) -> !item.is_valid())?

    return false unless _.isNumber(@range) && @range > 0

    true


  @from_json: (json) ->
    definition = new AntennaDefinition()
    definition.labor = _.map(json.labor, ResourceQuantity.from_json)
    definition.range = json.range
    definition
