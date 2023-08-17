# :dart: Dataflow tools for Dart 

[![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause) [![Twitter URL](https://img.shields.io/twitter/url/https/twitter.com/navibyte.svg?style=social&label=Follow%20%40navibyte)](https://twitter.com/navibyte) [![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

**Dataflow** - data structures, tools and utilities for 
[Dart](https://dart.dev/) and [Flutter](https://flutter.dev/) mobile developers
to help on handling dynamic structured data and fetching it from various data
sources.

Please see also geospatial specific data structures, tools and utilities at the
separate
[Geospatial tools for Dart](https://github.com/navibyte/geospatial) repository.

## :package: Packages

[Dart](https://dart.dev/) code packages published at 
[pub.dev](https://pub.dev/publishers/navibyte.com/packages):

Code           | Package | Description 
-------------- | --------| -----------
:spiral_notepad: [attributes](dart/attributes) | [![pub package](https://img.shields.io/pub/v/attributes.svg)](https://pub.dev/packages/attributes) | Decode and encode structured data type-safely from JSON. Utilities for data objects, entities and values.
:cloud: [datatools](dart/datatools) | [![pub package](https://img.shields.io/pub/v/datatools.svg)](https://pub.dev/packages/datatools) | Utilities to fetch data from HTTP and file resources and other data sources.

## :newspaper_roll: News

2023-08-17
* New versions based on [Dart 3](https://dart.dev/resources/dart-3-migration):
  * [attributes 1.0.0](https://pub.dev/packages/attributes/versions/1.0.0)
  * [datatools 1.0.0](https://pub.dev/packages/datatools/versions/1.0.0)

2023-03-14
* Release version 0.8.2 (maintenance fixes)

2022-03-10
* Release version 0.8.1 (with small documentation fixes)

2021-10-02
* Release version 0.8.0.
* Interfaces and class structures stabilized, no major breaking changes planned at least short-term.
* Changes on [attributes](https://pub.dev/packages/attributes):
  * [Apply very_good_analysis 2.3.0+ lint rules #13](https://github.com/navibyte/dataflow/issues/13)
  * [Simplify mapping iterables in toData and fromData implementations of common domain model classes #12](https://github.com/navibyte/dataflow/issues/12)
  * [Samples to compare using fromJson/toJson and using data objects provided by the attributes package #15](https://github.com/navibyte/dataflow/issues/15)
* Changes on [datatools](https://pub.dev/packages/datatools):
  * [Apply very_good_analysis 2.3.0+ lint rules #13](https://github.com/navibyte/dataflow/issues/13)

2021-08-10
* BETA version 0.7.0
* New features and large refactoring on [attributes](https://pub.dev/packages/attributes):
  * structured data now handled using new DataObject and DataArray classes
    * with decoding and encoding with JSON Objects and JSON Arrays
  * value conversion functions enhanced
  * [new sample domain model classes with JSON serialization](https://github.com/navibyte/dataflow/issues/10)
  * [mini-libraries restructured](https://github.com/navibyte/dataflow/issues/9)
  * other refactoring and smaller new features  
* Minor breaking changes on [datatools](https://pub.dev/packages/datatools):
  * support for "reviver" when decoding JSON, byte stream signature changed
* [Official Dart lint rules applied with recommend set](https://github.com/navibyte/dataflow/issues/2)

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

## :building_construction: Roadmap

See [issues](https://github.com/navibyte/dataflow/issues).

## :house_with_garden: Authors

This project is authored by [Navibyte](https://navibyte.com).

## :copyright: License

This project is licensed under the "BSD-3-Clause"-style license.

Please see the [LICENSE](LICENSE).


## :star: Links and other resources

Some external links and other resources.

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
