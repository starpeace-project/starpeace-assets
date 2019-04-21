_ = require('lodash')

BankDefinition = require('./bank/bank-definition')
FactoryDefinition = require('./factory/factory-definition')
HeadquartersDefinition = require('./headquarters/headquarters-definition')
AntennaDefinition = require('./media/antenna-definition')
MediaStationDefinition = require('./media/media-station-definition')
ParkDefinition = require('./park/park-definition')
ServiceDefinition = require('./service/service-definition')
StorageDefinition = require('./storage/storage-definition')
StoreDefinition = require('./store/store-definition')

ConstructionQuantity = require('./construction-quantity')

exports = module.exports = class SimulationDefinitionParser

  @definition_from_type: (json) ->
    return AntennaDefinition.from_json(json) if json.type == 'ANTENNA'
    return BankDefinition.from_json(json) if json.type == 'BANK'
    return FactoryDefinition.from_json(json) if json.type == 'FACTORY'
    return HeadquartersDefinition.from_json(json) if json.type == 'HEADQUARTERS'
    return MediaStationDefinition.from_json(json) if json.type == 'MEDIA_STATION'
    return ParkDefinition.from_json(json) if json.type == 'PARK'
    return ServiceDefinition.from_json(json) if json.type == 'SERVICE'
    return StorageDefinition.from_json(json) if json.type == 'STORAGE'
    return StoreDefinition.from_json(json) if json.type == 'STORE'
    throw "unknown simulation type #{json.type}"

  @from_json: (json) ->
    definition = SimulationDefinitionParser.definition_from_type(json)
    definition.id = json.id
    definition.type = json.type
    definition.max_level = json.max_level
    definition.construction_inputs = _.map(json.construction_inputs, ConstructionQuantity.from_json)
    definition.prestige = json.prestige || 0
    definition.beauty = json.beauty || 0
    definition
