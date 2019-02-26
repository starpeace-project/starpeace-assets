_ = require('lodash')

exports = module.exports = class SimulationDefinition

  toJSON: () ->
    {
      id: @id
      type: @type
      construction_inputs: @construction_inputs
    }

  is_valid: () ->
    return false unless _.isString(@id) && @id.length > 0
    return false unless _.isString(@type) && @type.length > 0
    true
