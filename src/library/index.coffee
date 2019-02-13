
BuildingDefinition = require('./building/building-definition')
BuildingImageDefinition = require('./building/building-image-definition')
BuildingSimulationDefinition = require('./building/building-simulation-definition')
CoordinateList = require('./building/coordinate-list')
Coordinate = require('./building/coordinate')

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
  BuildingSimulationDefinition
  CoordinateList
  Coordinate

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
