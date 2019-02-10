_ = require('lodash')

exports = module.exports = class CityZone

  toJSON: () ->
    {
      id: @id
      value: @value
      color: @color
    }

  is_valid: () ->
    return false unless _.isString(@id) && @id.length > 0
    return false unless @value?
    return false unless @color?
    true


  @from_json = (json) ->
    zone = new CityZone()
    zone.id = json.id
    zone.value = json.value
    zone.color = json.color
    zone
