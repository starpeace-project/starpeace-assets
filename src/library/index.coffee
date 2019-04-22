
BuildingDefinition = require('./building/building-definition')
BuildingImageDefinition = require('./building/building-image-definition')
CoordinateList = require('./building/coordinate-list')
Coordinate = require('./building/coordinate')

BuildingSimulationDefinition = require('./building/simulation/simulation-definition')
BuildingSimulationDefinitionParser = require('./building/simulation/simulation-definition-parser')
ConstructionQuantity = require('./building/simulation/construction-quantity')

BankDefinition = require('./building/simulation/bank/bank-definition')
CapitolDefinition = require('./building/simulation/civic/capitol-definition')
MausoleumDefinition = require('./building/simulation/civic/mausoleum-definition')
PortalDefinition = require('./building/simulation/civic/portal-definition')
TownhallDefinition = require('./building/simulation/civic/townhall-definition')
TradecenterDefinition = require('./building/simulation/civic/tradecenter-definition')
FactoryDefinition = require('./building/simulation/factory/factory-definition')
FactoryStage = require('./building/simulation/factory/factory-stage')
HeadquartersDefinition = require('./building/simulation/headquarters/headquarters-definition')
AntennaDefinition = require('./building/simulation/media/antenna-definition')
MediaStationDefinition = require('./building/simulation/media/media-station-definition')
ParkDefinition = require('./building/simulation/park/park-definition')
ServiceDefinition = require('./building/simulation/service/service-definition')
StorageDefinition = require('./building/simulation/storage/storage-definition')
StoreDefinition = require('./building/simulation/store/store-definition')
StoreProductCustomer = require('./building/simulation/store/store-product-customer')
StoreProductOutput = require('./building/simulation/store/store-product-output')
StoreProduct = require('./building/simulation/store/store-product')

CityZone = require('./industry/city-zone')
IndustryCategory = require('./industry/industry-category')
IndustryType = require('./industry/industry-type')
Level = require('./industry/level')
ResourceQuantity = require('./industry/resource-quantity')
ResourceType = require('./industry/resource-type')
ResourceUnit = require('./industry/resource-unit')

InventionDefinition = require('./invention/invention-definition')

CompanySeal = require('./seal/company-seal')

exports = module.exports = {
  BuildingDefinition
  BuildingImageDefinition
  CoordinateList
  Coordinate

  BuildingSimulationDefinition
  BuildingSimulationDefinitionParser
  ConstructionQuantity

  BankDefinition
  CapitolDefinition
  MausoleumDefinition
  PortalDefinition
  TownhallDefinition
  TradecenterDefinition
  FactoryDefinition
  FactoryStage
  HeadquartersDefinition
  AntennaDefinition
  MediaStationDefinition
  ParkDefinition
  ServiceDefinition
  StorageDefinition
  StoreDefinition
  StoreProductCustomer
  StoreProductOutput
  StoreProduct

  CityZone
  IndustryCategory
  IndustryType
  Level
  ResourceQuantity
  ResourceType
  ResourceUnit

  InventionDefinition

  CompanySeal
}
