_ = require('lodash')

FactoryDefinition = require('./factory-definition')
StorageDefinition = require('./storage-definition')
StoreDefinition = require('./store-definition')

ConstructionQuantity = require('./construction-quantity')

exports = module.exports = class SimulationDefinitionParser

  @definition_from_type: (json) ->
    return FactoryDefinition.from_json(json) if json.type == 'FACTORY'
    return StorageDefinition.from_json(json) if json.type == 'STORAGE'
    return StoreDefinition.from_json(json) if json.type == 'STORE'
    throw "unknown simulation type #{json.type}"

  @from_json: (json) ->
    definition = SimulationDefinitionParser.definition_from_type(json)
    definition.id = json.id
    definition.type = json.type
    definition.max_level = json.max_level
    definition.construction_inputs = _.map(json.construction_inputs, ConstructionQuantity.from_json)
    definition
