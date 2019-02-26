
BuildingDefinition = require('./building/building-definition')
BuildingImageDefinition = require('./building/building-image-definition')
CoordinateList = require('./building/coordinate-list')
Coordinate = require('./building/coordinate')

BuildingSimulationDefinition = require('./building/simulation/simulation-definition')
BuildingSimulationDefinitionParser = require('./building/simulation/simulation-definition-parser')
ConstructionQuantity = require('./building/simulation/construction-quantity')
FactoryDefinition = require('./building/simulation/factory-definition')
StorageDefinition = require('./building/simulation/storage-definition')
StoreDefinition = require('./building/simulation/store-definition')

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
  FactoryDefinition
  StorageDefinition
  StoreDefinition

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
