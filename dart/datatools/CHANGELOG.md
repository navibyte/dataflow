## 1.0.0

NOTE: Version 1.0.0 currently under development.

✨ New (2023-08): The version 1.0.0 requiring [Dart 3](https://dart.dev/resources/dart-3-migration). When Dart 2 is required, please use version 0.8.x.

🛠 Maintenance:
- The SDK constraint updated from '>=2.12.0 <4.0.0' to '>=3.0.0 <4.0.0'.
- Update copyright texts.
- Remove trunk files.
- Remove deprecated methods (`Content.stream`).

## 0.8.2

🛠 Maintenance:
- The dependency on `very_good_analysis` updated to 4.0.0+ 
- The SDK constraint updated from '>=2.12.0 <3.0.0' to '>=2.12.0 <4.0.0'.

## 0.8.1

- [Apply very_good_analysis 2.4.0+ lint rules #17](https://github.com/navibyte/dataflow/issues/17)
- Documentation fixes

## 0.8.0

- Release version 0.8.0
- [Apply very_good_analysis 2.3.0+ lint rules #13](https://github.com/navibyte/dataflow/issues/13)

## 0.7.0

- BETA version 0.7.0 with minor breaking changes
- Support for an optional reviver-function when decoding JSON data.
  - `Object? Function(Object? key, Object? value)? reviver})`
- `Content` class getter for stream changed as: `Stream<List<int>> byteStream()` 
  - now deprecated: `Future<Stream<List<int>>> get stream`   
- Add new factory contructors to `ClientException`  
- [Official Dart lint rules applied with recommend set #2](https://github.com/navibyte/dataflow/issues/2)

## 0.6.0

- BETA version 0.6.0 with minor breaking changes
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
- [UriResolver moved and new Anchor interface](https://github.com/navibyte/geospatial/issues/20)
- [New package "datatools/base_api.dart"](https://github.com/navibyte/geospatial/issues/21)
- Controller interface method: `C headers(Map<String, String>? headers);`
  - changed `headers` to required: `C headers(Map<String, String> headers);`
- many other smaller changes and optimizations partially due issues #8 

## 0.5.0

- BETA version 0.5.0 with stable null-safety requiring the stable Dart 2.12

## 0.5.0-nullsafety.0

- BETA version 0.5.0 with breaking changes compared to 0.4.0
- Quite extensive refactoring and partially fully rewritten
- New dependency: `path` (^1.8.0-nullsafety.3)
- Changed dependency: `http_parser` (^4.0.0-nullsafety)
- Changed dependency: `http` (^0.13.0-nullsafety.0)
- [Link meta data lists #17](https://github.com/navibyte/geospatial/issues/17)
- [Client-side support for calling reading GeoJSON web or file resource #10](https://github.com/navibyte/geospatial/issues/10)
- Mini-libraries provided by the package refactored:
  - fetch_api
    - Fetch API abstraction (content, control data, exceptions, fetch interface).
  - fetch_file
    - Fetch API binding to file resources.
  - fetch_http
    - Fetch API binding to HTTP and HTTPS resources.
  - meta_link
    - Metadata structures to handle links.
- Code also restructured under lib/src
  - api
    - content
    - control
    - exceptions
    - fetch
    - resolver
  - file
    - fetch
  - http
    - fetch
  - meta
    - link
          
## 0.4.0-nullsafety.0

- Initial alpha version 0.4.0 (version starting with aligment to other packages)
- Designed for null-safety (requires sdk: '>=2.12.0-0 <3.0.0')
- Uses as dependency: `equatable` (^2.0.0-nullsafety.0)
- Uses as dependency: `meta` (^1.3.0-nullsafety.6)
- Uses as dependency: `http` (^0.12.2)
- Uses as dependency: `http_parser` (^3.1.4)
- "client", "client_http" and "utils" libs were moved here from `geodata`
- "meta" with Link class was moved here from `geocore`
- Structure of lib/src folder:
  - client
    - base
    - http
  - meta
    - link
  - utils
    - format
- Mini-libraries provided by the package:
  - 'package:datatools/client_base.dart'
  - 'package:datatools/client_http.dart'
  - 'package:datatools/meta_link.dart'
- The whole library is available by:
  - 'package:datatools/datatools.dart'
