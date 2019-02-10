path = require('path')
fs = require('fs')
_ = require('lodash')
Table = require('cli-table3')

FileUtils = require('./utils/file-utils')
Utils = require('./utils/utils')

{
  BuildingDefinition
  BuildingSimulationDefinition
  ResourceType
} = require('../lib')


console.log "\n===============================================================================\n"
console.log " analyze.js - https://www.starpeace.io\n"
console.log " analyze and calculate economy projections from simulation configurations,"
console.log " helping identify balance or other problems.\n"
console.log " see README.md for more details"
console.log "\n===============================================================================\n"

root = process.cwd()
source_dir = path.join(root, process.argv[2])

building_root_dir = path.join(source_dir, 'buildings')
industry_root_dir = path.join(source_dir, 'industry')

console.log " input directory: #{source_dir}"
console.log " building root directory: #{building_root_dir}"
console.log " industry root directory: #{industry_root_dir}"
console.log "\n-------------------------------------------------------------------------------\n"


load_data = () -> new Promise (resolve, reject) ->
  try
    resolve({
      resource_types_by_id: _.keyBy(FileUtils.parse_files(industry_root_dir, ['resource-types.json'], [], ResourceType.from_json), 'id')
      definitions_by_id: _.keyBy(FileUtils.parse_files(building_root_dir, ['.json'], ['-simulation.json', '-image.json'], BuildingDefinition.from_json), 'id')
      simulation_definitions_by_type: _.groupBy(FileUtils.parse_files(building_root_dir, ['-simulation.json'], [], BuildingSimulationDefinition.from_json), 'type')
    })
  catch err
    reject(err)


Promise.resolve load_data()
  .then (analysis_data) ->

    building_financials = new Table({
        head: ['id', 'capex', 'opex req', 'opex opt', 'opex', 'income', 'profit hr', 'roi hrs', 'roi mo']
      , colWidths: [30, 12, 12, 10, 10, 10, 12, 12]
    })

    for building in analysis_data.simulation_definitions_by_type.INDUSTRY || []
      opex_required = _.reduce(building.required_inputs, ((result, value) -> result + value.max * analysis_data.resource_types_by_id[value.resource].price), 0)
      opex_optional = _.reduce(building.optional_inputs, ((result, value) -> result + value.max * analysis_data.resource_types_by_id[value.resource].price), 0)
      income = _.reduce(building.outputs, ((result, value) -> result + value.max * analysis_data.resource_types_by_id[value.resource].price), 0)

      capex = building.cost
      profit = Math.ceil(income - (opex_required + opex_optional))

      roi_hrs = if profit < 0 then -1 else Math.ceil(capex / profit)
      roi_days = if roi_hrs < 0 then -1 else Math.ceil(roi_hrs / 24)
      roi_mo = if roi_hrs < 0 then -1 else Math.ceil(roi_days / 30)

      building_financials.push [
        building.id,
        capex,
        opex_required,
        opex_optional,
        opex_optional + opex_required,
        income,
        profit,
        if roi_hrs < 0 then 'never' else roi_hrs,
        if roi_mo < 0 then 'never' else roi_mo
      ]

    building_financials.sort (lhs, rhs) ->
      return lhs[6] - rhs[6] if lhs[7] == rhs[7]
      return -1 if lhs[7] == 'never'
      return 1 if rhs[7] == 'never'
      rhs[7] - lhs[7]

    console.log building_financials.toString()

    console.log "\n [DONE] finished STARPEACE analyze successfully!"

  .catch (err) ->
    console.log "\n-------------------------------------------------------------------------------\n"
    console.log " [ERROR] encountered problems during STARPEACE analyze: #{err}\n"
    process.exit(1)
