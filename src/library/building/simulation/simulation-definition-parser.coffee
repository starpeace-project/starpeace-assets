_ = require('lodash')

BankDefinition = require('./bank/bank-definition')
CapitolDefinition = require('./civic/capitol-definition')
MausoleumDefinition = require('./civic/mausoleum-definition')
PortalDefinition = require('./civic/portal-definition')
TownhallDefinition = require('./civic/townhall-definition')
TradecenterDefinition = require('./civic/tradecenter-definition')
FactoryDefinition = require('./factory/factory-definition')
HeadquartersDefinition = require('./headquarters/headquarters-definition')
AntennaDefinition = require('./media/antenna-definition')
MediaStationDefinition = require('./media/media-station-definition')
OfficeDefinition = require('./office/office-definition')
ParkDefinition = require('./park/park-definition')
ResidenceDefinition = require('./residence/residence-definition')
ServiceDefinition = require('./service/service-definition')
StorageDefinition = require('./storage/storage-definition')
StoreDefinition = require('./store/store-definition')

ConstructionQuantity = require('./construction-quantity')

exports = module.exports = class SimulationDefinitionParser

  @definition_from_type: (json) ->
    return AntennaDefinition.from_json(json) if json.type == 'ANTENNA'
    return BankDefinition.from_json(json) if json.type == 'BANK'
    return CapitolDefinition.from_json(json) if json.type == 'CAPITOL'
    return FactoryDefinition.from_json(json) if json.type == 'FACTORY'
    return HeadquartersDefinition.from_json(json) if json.type == 'HEADQUARTERS'
    return MediaStationDefinition.from_json(json) if json.type == 'MEDIA_STATION'
    return MausoleumDefinition.from_json(json) if json.type == 'MAUSOLEUM'
    return OfficeDefinition.from_json(json) if json.type == 'OFFICE'
    return ParkDefinition.from_json(json) if json.type == 'PARK'
    return PortalDefinition.from_json(json) if json.type == 'PORTAL'
    return ResidenceDefinition.from_json(json) if json.type == 'RESIDENCE'
    return ServiceDefinition.from_json(json) if json.type == 'SERVICE'
    return StorageDefinition.from_json(json) if json.type == 'STORAGE'
    return StoreDefinition.from_json(json) if json.type == 'STORE'
    return TownhallDefinition.from_json(json) if json.type == 'TOWNHALL'
    return TradecenterDefinition.from_json(json) if json.type == 'TRADECENTER'
    throw "unknown simulation type #{json.type}"

  @from_json: (json) ->
    definition = SimulationDefinitionParser.definition_from_type(json)
    definition.id = json.id
    definition.type = json.type
    definition.max_level = json.max_level
    definition.construction_inputs = _.map(json.construction_inputs, ConstructionQuantity.from_json)
    definition.prestige = json.prestige || 0
    definition.maintainance = json.maintainance || 0
    definition.beauty = json.beauty || 0
    definition.pollution = json.pollution || 0
    definition
