_ = require('lodash')

SimulationDefinition = require('../simulation-definition')
ResourceQuantity = require('../../../industry/resource-quantity')

exports = module.exports = class ResidenceDefinition extends SimulationDefinition

  toJSON: () ->
    _.assign(super.toJSON(), {
      resident_type: @resident_type
      capacity: @capacity
      efficiency: @efficiency
      crime_resistence: @crime_resistence
      pollution_resistence: @pollution_resistence
    })

  is_valid: () ->
    return false unless super.is_valid()

    return false unless _.isString(@resident_type) && @resident_type.length > 0
    return false unless _.isNumber(@capacity) && @capacity > 0
    return false unless _.isNumber(@efficiency) && @efficiency > 0 && @efficiency <= 4.0
    return false unless _.isNumber(@crime_resistence) && @crime_resistence >= 0 && @crime_resistence <= 4.0
    return false unless _.isNumber(@pollution_resistence) && @pollution_resistence >= 0 && @pollution_resistence <= 4.0

    true


  @from_json: (json) ->
    definition = new ResidenceDefinition()
    definition.resident_type = json.resident_type
    definition.capacity = json.capacity
    definition.efficiency = json.efficiency
    definition.crime_resistence = json.crime_resistence || 0
    definition.pollution_resistence = json.pollution_resistence || 0
    definition
