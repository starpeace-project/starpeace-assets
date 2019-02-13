_ = require('lodash')

exports = module.exports = class Level

  toJSON: () ->
    {
      id: @id
      label: @label
    }

  is_valid: () ->
    return false unless _.isString(@id) && @id.length > 0
    return false unless @label?
    true


  @from_json = (json) ->
    level = new Level()
    level.id = json.id
    level.label = json.label
    level
