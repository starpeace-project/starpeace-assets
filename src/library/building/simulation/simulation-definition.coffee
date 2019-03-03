_ = require('lodash')

exports = module.exports = class SimulationDefinition

  toJSON: () ->
    {
      id: @id
      type: @type
      max_level: @max_level
      construction_inputs: @construction_inputs
    }

  is_valid: () ->
    return false unless _.isString(@id) && @id.length > 0
    return false unless _.isString(@type) && @type.length > 0
    return false unless _.isNumber(@max_level) && @max_level > 0
    true
