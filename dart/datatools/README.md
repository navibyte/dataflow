<h2 align="center">Unified Fetch API for HTTP and files</h2>

[![pub package](https://img.shields.io/pub/v/datatools.svg)](https://pub.dev/packages/datatools) [![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause) [![style: very good analysis](https://img.shields.io/badge/style-very_good_analysis-B22C89.svg)](https://pub.dev/packages/very_good_analysis)

Key features:
* Fetch data from HTTP and file resources and other data sources.
* Fetch API abstraction (content, control data, exceptions, fetch interface).
* Fetch API binding to HTTP and HTTPS resources (using [http](https://pub.dev/packages/http)).
* Fetch API binding to file resources (based on `dart:io`).
* Metadata structures to handle links.

## Usage

Please, see more detailed examples on 
[sample code](example/datatools_example.dart).

Imports when using Fetch API for HTTP:

```dart
import 'package:datatools/fetch_http.dart';
```

Setting up a HTTP fetcher, fetching JSON, and also handling errors:

```dart
  // create a simple fetcher with an endpoint and headers
  final fetcher = HttpFetcher.simple(
          endpoints: [Uri.parse('https://jsonplaceholder.typicode.com/')])
      .headers({'user-agent': 'myapp'});

  // fetch by a relative path, get content as JSON and handle errors
  try {
    final json = 
        await fetcher.fetchJson(Uri(path: 'posts/1')) as Map<String, dynamic>;
    // do something with JSON data...
  } on OriginException catch (e) {
    // handle exceptions ("not found" etc.) issued by origin server
  } catch (e) {
    // handle other exceptions, like caused by client code 
  }
```

The package supports using the same Fetch API interface also for reading files:

```dart
  // create a file fetcher with a directory as a base path
  final fetcher = FileFetcher.basePath('test');

  // fetch json from a file resource
  try {
    final json = await fetcher.fetchJson(Uri(path: 'file_test_data.json'))
        as Map<String, dynamic>;
    // do something with JSON data...
  } on OriginException catch (e) {
    // handle exceptions ("not found" etc.) issued by file system
  } catch (e) {
    // handle other exceptions, like caused by client code 
  }
```

Both data source bindings share the same Fetch API interface as described below:

```dart
/// An interface to fetch data from a resource like Web API, a cache or a file.
abstract class FetchApi<C extends Content> {
  const FetchApi();

  /// Fetch (read fully) content body from a resource identified by [reference].
  ///
  /// Depending on the API the [reference] can be a relative path, an absolute
  /// URL, a key, or other identifier relevant on a context of an API.
  ///
  /// Throws an `ApiException` if fetching fails. Implementations like HTTP
  /// fetcher may also throw other status codes than codes for success as
  /// exceptions.
  Future<C> fetch(Uri reference);

  /// Fetch content as a stream from a resource identified by [reference].
  Future<C> fetchStream(Uri reference);

  /// Fetch content body as text from a resource identified by [reference].
  Future<String> fetchText(Uri reference);

  /// Fetch content body as bytes from a resource identified by [reference].
  Future<Uint8List> fetchBytes(Uri reference);

  /// Fetch content body as JSON data from a resource identified by [reference].
  ///
  /// An optional [reviver] function is applied when decoding json string data.
  /// See `JsonCodec` of the `dart:convert` package for more information.
  Future<dynamic> fetchJson(Uri reference,
      {Object? Function(Object? key, Object? value)? reviver});
}
```

Key methods and properties available on the `Content` interface are:

```dart
  /// The URI `reference` to a resource this content is referring.
  Uri get reference;

  /// The expected media type.
  MediaType get mediaType;

  /// The expected charset `encoding`.
  Encoding get encoding;

  /// An optional content length as number of bytes.
  int? get contentLength;

  /// Reads content body as text and returns a future of String.
  Future<String> get text;

  /// Reads content body as bytes and returns a future of Uint8List.
  Future<Uint8List> get bytes;

  /// Reads content body as bytes and returns a future of ByteData.
  ///
  /// Optional `start` and `end` parameters define a range to be read. It's
  /// required that `0 ≤ start ≤ end ≤ contentLength`. See also
  /// `ByteData.sublistView` for reference.
  Future<ByteData> byteData([int start = 0, int? end]);

  /// Returns content body as a single-subscription byte stream.
  Stream<List<int>> byteStream();

  /// Reads and decodes content body as a JSON object, returned in a future.
   Future<dynamic> decodeJson();
```

## Installing

The package supports Dart [null-safety](https://dart.dev/null-safety) and 
using it requires at least
[Dart 2.12](https://medium.com/dartlang/announcing-dart-2-12-499a6e689c87)
from the stable channel. 

In the `pubspec.yaml` of your project add the dependency:

```yaml
dependencies:
  datatools: ^0.8.1 
```

All dependencies used by `datatools` are also ready for 
[null-safety](https://dart.dev/null-safety)!

## Libraries

The package contains following mini-libraries:

Library         | Description 
----------------| -----------
**base_api**   | Generic API abstractions (addresses, content, control data, exceptions).
**fetch_api**   | Fetch API abstraction (addresses, content, control data, exceptions, fetch).
**fetch_http**  | Fetch API binding to HTTP and HTTPS resources (using [http](https://pub.dev/packages/http)).
**fetch_file**  | Fetch API binding to file resources (based on `dart:io`).
**meta_link**   | Metadata structures to handle links.

The *fetch_file* mini library works on all platforms except web. Other libraries
should work on all Dart platforms.

For example to access a mini library you should use an import like:

```dart
import 'package:datatools/fetch_http.dart';
```

To use all (expect *fetch_file* that must be imported separately) libraries of the 
package:

```dart
import 'package:datatools/datatools.dart';
```

## Authors

This project is authored by [Navibyte](https://navibyte.com).

More information and other links are available at the
[dataflow](https://github.com/navibyte/dataflow) repository from GitHub. 

## License

This project is licensed under the "BSD-3-Clause"-style license.

Please see the 
[LICENSE](https://github.com/navibyte/dataflow/blob/main/LICENSE).