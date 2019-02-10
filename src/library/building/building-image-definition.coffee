_ = require('lodash')

CoordinateList = require('./coordinate-list')

exports = module.exports = class BuildingImageDefinition
  constructor: (@id) ->
    @seal_ids = []

  is_valid: () ->
    return false unless @id?.length > 0
    return false unless @image_path?.length > 0
    return false unless @tile_width? && @tile_width > 0
    return false unless @tile_height? && @tile_height > 0
    return false unless @hit_area?.length > 0
    true

  toJSON: () ->
    {
      id: @image_path
      image_path: @image_path
      tile_width: @tile_width
      tile_height: @tile_height
      hit_area: @hit_area
    }

  @from_json: (json) ->
    definition = new BuildingImageDefinition(json.id)
    definition.image_path = json.image_path
    definition.tile_width = json.tile_width
    definition.tile_height = json.tile_height
    definition.hit_area = _.map(json.hit_area, CoordinateList.from_json)
    definition
