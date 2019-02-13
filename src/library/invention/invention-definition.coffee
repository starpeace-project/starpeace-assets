_ = require('lodash')

exports = module.exports = class InventionDefinition
  constructor: (@id) ->

  is_valid: () ->
    return false unless @id?.length > 0

    return false unless @category?.length > 0
    return false unless @industry_type?.length > 0

    return false unless @name?
    return false unless @description?

    # TODO: validate @properties
    true

  @from_json: (json) ->
    definition = new InventionDefinition(json.id)
    definition.category = json.category
    definition.industry_type = json.industry_type
    definition.name = json.name
    definition.description = json.description
    definition.depends_on = json.depends_on || []
    definition.properties = json.properties || {}

    definition
