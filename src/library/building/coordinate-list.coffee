_ = require('lodash')

Coordinate = require('./coordinate')

exports = module.exports = class CoordinateList
  constructor: () ->
    @coordinates = []

  toJSON: () -> _.map(@coordinates, 'toJSON')

  @from_json: (json) ->
    list = new CoordinateList()
    list.coordinates = _.map(json, Coordinate.from_json)
    list
