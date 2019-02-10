
exports = module.exports = class Coordinate
  constructor: (@x, @y) ->

  toJSON: () ->
    {
      x: @x
      y: @y
    }

  @from_json: (json) -> new Coordinate(json.x, json.y)
