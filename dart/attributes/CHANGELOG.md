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
