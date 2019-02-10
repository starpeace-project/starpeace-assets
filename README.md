
# starpeace-assets

[![GitHub release](https://img.shields.io/github/release/starpeace-project/starpeace-assets.svg)](https://github.com/starpeace-project/starpeace-assets/releases/)
[![Build Status](https://travis-ci.org/starpeace-project/starpeace-assets.svg)](https://travis-ci.org/starpeace-project/starpeace-assets)
[![License: Commercial](https://img.shields.io/badge/license-Commercial-yellowgreen.svg)](./LICENSE)
[![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)](https://opensource.org/licenses/MIT)

Assets for [STARPEACE](https://www.starpeace.io), including gameplay images, sounds, definitions, and baseline simulation configurations.

## Documentation

Please [see legacy assets](./LEGACY.md) for more information about cleanup of legacy assets.

## Tools

- ```grunt audit``` - provides a read-only analysis of game image assets, including checking for various land metadata and images consistency problems
- ```grunt export --type=bi``` - export assets text languages into translations. type option either ```b``` for buildings and/or ```i``` for inventions
- ```grunt import --type=bi``` - import translations into assets text languages. type option either ```b``` for buildings and/or ```i``` for inventions

## Contributing

Please [join Discord chatroom](https://discord.gg/TF9Bmsj) and [read the development guide](./DEVELOPMENT.md) to learn more.

## License

All content of starpeace-assets is commercially licensed; any unauthorized and/or unapproved use is not permitted. Underlying source code used to inspect, process, and audit content is licensed under the [MIT license](https://opensource.org/licenses/mit-license.php). Please contact info@starpeace.io for licensing information.
