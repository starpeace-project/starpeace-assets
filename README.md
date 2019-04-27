
# starpeace-assets

[![GitHub release](https://img.shields.io/github/release/starpeace-project/starpeace-assets.svg)](https://github.com/starpeace-project/starpeace-assets/releases/)
[![Build Status](https://travis-ci.org/starpeace-project/starpeace-assets.svg)](https://travis-ci.org/starpeace-project/starpeace-assets)
[![License: Commercial](https://img.shields.io/badge/license-Commercial-yellowgreen.svg)](./LICENSE)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

Assets for [STARPEACE](https://www.starpeace.io), including gameplay images, sounds, definitions, and baseline simulation configurations.

## Documentation

starpeace-assets is organized by directory and depends on library types from [starpeace-assets-types](https://github.com/starpeace-project/starpeace-assets-types):

- **/assets/** - raw gameplay assets and simulation configurations
- **/src/tools/** - internal analysis and manipulation tools for management of raw assets
- **/translations/** - internal bulk language translations used with tools to manipulate raw assets
- **/lib/** - auto-generated javascript version of core library
- **/build/** - auto-generated javascript version of tools logic

## Tools

- ```grunt audit``` - provides a read-only analysis of game assets, including checking for gameplay metadata, simulation configuration, and image asset consistency problems
- ```grunt export --type=bi``` - export assets text languages into translations. type option either ```b``` for buildings and/or ```i``` for inventions
- ```grunt import --type=bi``` - import translations into assets text languages. type option either ```b``` for buildings and/or ```i``` for inventions

## Contributing

Please [join Discord chatroom](https://discord.gg/TF9Bmsj) and [read the development guide](./DEVELOPMENT.md) to learn more.

## License

All content of starpeace-assets is commercially licensed; any unauthorized and/or unapproved use is not permitted. Underlying source code used to inspect, process, and audit content is licensed under the [MIT license](https://opensource.org/licenses/mit-license.php). Please contact info@starpeace.io for licensing information.
