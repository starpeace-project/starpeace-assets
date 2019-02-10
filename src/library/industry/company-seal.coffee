_ = require('lodash')

exports = module.exports = class CompanySeal

  toJSON: () ->
    {
      id: @id
      name_short: @name_short
      name_long: @name_long
    }

  is_valid: () ->
    return false unless _.isString(@id) && @id.length > 0
    return false unless @name_short?
    return false unless @name_long?
    true


  @from_json = (json) ->
    seal = new CompanySeal()
    seal.id = json.id
    seal.name_short = json.name_short
    seal.name_long = json.name_long
    seal
