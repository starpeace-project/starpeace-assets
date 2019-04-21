_ = require('lodash')

FactoryStage = require('./factory-stage')

SimulationDefinition = require('../simulation-definition')

exports = module.exports = class FactoryDefinition extends SimulationDefinition

  toJSON: () ->
    _.assign(super.toJSON(), {
      stages: @stages
    })

  is_valid: () ->
    return false unless super.is_valid()
    return false unless Array.isArray(@stages) && @stages?.length > 0
    return false if _.find(@stages, (stage) -> !stage.is_valid())?
    true


  @from_json: (json) ->
    definition = new FactoryDefinition()
    definition.stages = _.map(json.stages, FactoryStage.from_json)
    definition
