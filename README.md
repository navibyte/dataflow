# :dart: Dataflow tools for Dart 

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause) [![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/navibyte.svg?style=social&label=Follow%20%40navibyte)](https://twitter.com/navibyte)

**Dataflow** - data structures, tools and utilities for 
[Dart](https://dart.dev/) and [Flutter](https://flutter.dev/) mobile developers
to help on handling dynamic structured data and fetching it from various data
sources.

Please see also geospatial specific data structures, tools and utilities at the
separate
[Geospatial tools for Dart](https://github.com/navibyte/geospatial) repository.

Packages and documentation are published at [pub.dev](https://pub.dev/). 

Latest package releases:

Package @ pub.dev | Version | Documentation | Example code 
----------------- | --------| ------------- | -----------
:spiral_notepad: [attributes](https://pub.dev/packages/attributes) | [![pub package](https://img.shields.io/pub/v/attributes.svg)](https://pub.dev/packages/attributes) | [API reference](https://pub.dev/documentation/attributes/latest/) | [Example](https://pub.dev/packages/attributes/example)
:cloud: [datatools](https://pub.dev/packages/datatools) | [![pub package](https://img.shields.io/pub/v/datatools.svg)](https://pub.dev/packages/datatools) | [API reference](https://pub.dev/documentation/datatools/latest/) | [Example](https://pub.dev/packages/datatools/example)

All packages supports Dart [null-safety](https://dart.dev/null-safety) and 
using them requires at least
[Dart 2.12](https://medium.com/dartlang/announcing-dart-2-12-499a6e689c87)
from the stable channel. Please see the official 
[null-safety migration guide](https://dart.dev/null-safety/migration-guide).

## :page_facing_up: Code

**This repository is at BETA stage, interfaces not fully final yet.** 

This repository contains the following [Dart](https://dart.dev/) code 
packages:

Code @ GitHub | SDK | Description 
------------- | --- | -----------
:spiral_notepad: [attributes](dart/attributes) | Dart | Generic data structures for values, properties, identifiers and entities with type and null safe accessors.
:cloud: [datatools](dart/datatools) | Dart | Utilities to fetch data from HTTP and file resources and other data sources.

## :newspaper_roll: News

2021-04-25
* BETA version 0.6.0
* This new GitHub repository named **dataflow** created
  * with [attributes](https://pub.dev/packages/attributes) and [datatools](https://pub.dev/packages/datatools) packages included starting from the version 0.6.0
  * previously on the [geospatial](https://github.com/navibyte/geospatial) repo
* [Lint rules and analysis options updated](https://github.com/navibyte/geospatial/issues/8)
* Also `implicit-casts` and `implicit-dynamic` set to false requiring code changes
* New features on [attributes](https://pub.dev/packages/attributes):
  * refactored value accessors and mixins
  * PropertyMap (type and null safe access to `Map<String, dynamic` data) enchanced  
  * PropertyList (type and null safe access to `List<dynamic` data) introduced  

2021-03-03
* BETA version 0.5.0 with stable sound null-safety on all packages requiring the stable [Dart 2.12](https://medium.com/dartlang/announcing-dart-2-12-499a6e689c87)

Please check history for previous releases from the
[Geospatial tools for Dart](https://github.com/navibyte/geospatial) repository.

## :house_with_garden: Authors

This project is authored by [Navibyte](https://navibyte.com).

## :copyright: License

This project is licensed under the "BSD-3-Clause"-style license.

Please see the [LICENSE](LICENSE).


## :star: Links and other resources

Some external links and other resources.

### Dart and Flutter programming

SDKs:
* [Dart](https://dart.dev/)
* [Flutter](https://flutter.dev/) 

Latest on SDKs
* [Dart 2.12](https://medium.com/dartlang/announcing-dart-2-12-499a6e689c87)
* [Flutter 2](https://developers.googleblog.com/2021/03/announcing-flutter-2.html)
* [What’s New in Flutter 2](https://medium.com/flutter/whats-new-in-flutter-2-0-fe8e95ecc65)

Packages
* [pub.dev](https://pub.dev/)

Null-safety:
* Dart [null-safety](https://dart.dev/null-safety)
* The official [null-safety migration guide](https://dart.dev/null-safety/migration-guide)
* [Preparing the Dart and Flutter ecosystem for null safety](https://medium.com/dartlang/preparing-the-dart-and-flutter-ecosystem-for-null-safety-e550ce72c010)

Guidelines
* [Effective Dart](https://dart.dev/guides/language/effective-dart)

Roadmaps
* [Flutter roadmap](https://github.com/flutter/flutter/wiki/Roadmap)

### Dart and Flutter libraries

There are thousands of excellent libraries available at 
[pub.dev](https://pub.dev/).

Here listed only those that are used (depended directly) by code packages of
this repository:

Package @ pub.dev | Code @ GitHub | Description
----------------- | ------------- | -----------
[equatable](https://pub.dev/packages/equatable) | [felangel/equatable](https://github.com/felangel/equatable) | Simplify Equality Comparisons | A Dart abstract class that helps to implement equality without needing to explicitly override == and hashCode.
[http](https://pub.dev/packages/http) | [dart-lang/http](https://github.com/dart-lang/http) | A composable API for making HTTP requests in Dart.
[http_parser](https://pub.dev/packages/http_parser) | [dart-lang/http_parser](https://github.com/dart-lang/http_parser) | A platform-independent Dart package for parsing and serializing HTTP formats.
[intl](https://pub.dev/packages/intl) | [dart-lang/intl](https://github.com/dart-lang/intl) | Internationalization and localization support.
[meta](https://pub.dev/packages/meta) | [dart-lang/sdk](https://github.com/dart-lang/sdk/tree/master/pkg/meta) | This package defines annotations that can be used by the tools that are shipped with the Dart SDK.
[path](https://pub.dev/packages/path) | [dart-lang/path](https://github.com/dart-lang/path) | A string-based path manipulation library.
