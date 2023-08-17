## 1.0.0

NOTE: Version 1.0.0 currently under development.

✨ New (2023-08): The version 1.0.0 requiring [Dart 3](https://dart.dev/resources/dart-3-migration). When Dart 2 is required, please use version 0.8.x.

⚠️ Breaking changes:
- [Classes enhanced with Dart 3 class modifiers #18](https://github.com/navibyte/dataflow/issues/18)

🛠 Maintenance:
- The SDK constraint updated from '>=2.12.0 <4.0.0' to '>=3.0.0 <4.0.0'.
- Mark utility methods with @internal.
- Remove trunk file for utils.
- Update copyright texts.
- Fix some toString() methods.

## 0.8.2

🛠 Maintenance:
- The dependency on `intl` updated to 0.18.0+
- The dependency on `very_good_analysis` updated to 4.0.0+ 
- The SDK constraint updated from '>=2.12.0 <3.0.0' to '>=2.12.0 <4.0.0'.

## 0.8.1

- [Apply very_good_analysis 2.4.0+ lint rules #17](https://github.com/navibyte/dataflow/issues/17)
- Documentation fixes

## 0.8.0

- Release version 0.8.0
- [Apply very_good_analysis 2.3.0+ lint rules #13](https://github.com/navibyte/dataflow/issues/13)
- [Simplify mapping iterables in toData and fromData implementations of common domain model classes #12](https://github.com/navibyte/dataflow/issues/12)
- [Samples to compare using fromJson/toJson and using data objects provided by the attributes package #15](https://github.com/navibyte/dataflow/issues/15)

## 0.7.3

- Documentation updates, no library code changes.

## 0.7.2

- Small fix on export definitions of `package:attributes/data.dart`

## 0.7.1

- Small documentation fixes, no library code changes.

## 0.7.0

- BETA version 0.7.0 with breaking changes
- [Add new sample with domain model classes and JSON serialization #10](https://github.com/navibyte/dataflow/issues/10)
- [Structure mini-libraries provided by the attributes package #9](https://github.com/navibyte/dataflow/issues/9)
- [Properties, PropertyMap and PropertList refactored with new features and structure into DataElement, DataObject and DataArray classes #8](https://github.com/navibyte/dataflow/issues/8)
- [Add empty check getters to Counted interface #7](https://github.com/navibyte/dataflow/issues/7)
- [Separate mini library for specialized FormatException exceptions #6](https://github.com/navibyte/dataflow/issues/6)
- [Add new value conversion functions and apply consistent naming #5](https://github.com/navibyte/dataflow/issues/5)
- [Restructure primitive and value accessor interfaces #4](https://github.com/navibyte/dataflow/issues/4)
- [Restructure primitive value interfaces #3](https://github.com/navibyte/dataflow/issues/3)
- [Official Dart lint rules applied with recommend set #2](https://github.com/navibyte/dataflow/issues/2)

## 0.6.0

- BETA version 0.6.0 with some breaking changes
- The Github repository changed as the package actually has nothing geospatial
  - Old : https://github.com/navibyte/geospatial
  - New : https://github.com/navibyte/dataflow
  - Still some issues on the old repo, new issues are managed on the new home
  - Code history for versions 0.5.0 and before that on the old repository
  - Dart packages owned by repositories after these changes:
    - https://github.com/navibyte/dataflow : attributes, datatools 
    - https://github.com/navibyte/geospatial : geocore, geodata
- [Lint rules and analysis options updated](https://github.com/navibyte/geospatial/issues/8)
- Also `implicit-casts` and `implicit-dynamic` to false requiring code changes
- [ValueAccessor and PropertyMap changes](https://github.com/navibyte/geospatial/issues/19)
- Abstract Properties class extending ValueAccessor
  - extened by PropertyMap and PropertyList
- PropertyList class
- Many other smaller changes and optimizations partially due issues #8 and #19

## 0.5.0

- BETA version 0.5.0 with stable null-safety

## 0.5.0-nullsafety.0

- BETA version 0.5.0 without any breaking changes compared to 0.4.0

## 0.4.0-nullsafety.0

- Initial alpha version 0.4.0 (version starting with aligment to other packages)
- Designed for null-safety (requires sdk: '>=2.12.0-0 <3.0.0')
- Uses as dependency: `equatable` (^2.0.0-nullsafety.0)
- Uses as dependency: `meta` (^1.3.0-nullsafety.6)
- Uses as dependency: `intl` (^0.17.0-nullsafety.2)
- Some non-geospatial base code was moved here from `geocore`, then refactored
- Structure of lib/src folder:
  - collection
  - entity
  - values
- Mini-libraries provided by the package:
  - 'package:attributes/collection.dart'
  - 'package:attributes/entity.dart'
  - 'package:attributes/values.dart'
- The whole library is available by:
  - 'package:attributes/attributes.dart'
