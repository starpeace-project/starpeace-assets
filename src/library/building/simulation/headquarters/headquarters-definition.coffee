_ = require('lodash')

SimulationDefinition = require('../simulation-definition')
ResourceQuantity = require('../../../industry/resource-quantity')

exports = module.exports = class HeadquartersDefinition extends SimulationDefinition

  toJSON: () ->
    _.assign(super.toJSON(), {
      labor: @labor
    })

  is_valid: () ->
    return false unless super.is_valid()
    return false unless Array.isArray(@labor) && @labor?.length > 0
    return false if _.find(@labor, (item) -> !item.is_valid())?

    return false unless @beauty > 0 # TODO: may want to revisit for crime hq's

    true


  @from_json: (json) ->
    definition = new HeadquartersDefinition()
    definition.labor = _.map(json.labor, ResourceQuantity.from_json)
    definition
