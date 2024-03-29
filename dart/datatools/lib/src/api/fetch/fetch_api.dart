// Copyright (c) 2020-2023 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'dart:typed_data';

import '/src/api/content/content.dart';

/// An interface to fetch data from a resource like Web API, a cache or a file.
abstract interface class FetchApi<C extends Content> {
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
  ///
  /// Depending on the API the [reference] can be a relative path, an absolute
  /// URL, a key, or other identifier relevant on a context of an API.
  ///
  /// Throws an `ApiException` if fetching fails. Implementations like HTTP
  /// fetcher may also throw other status codes than codes for success as
  /// exceptions.
  Future<C> fetchStream(Uri reference);

  /// Fetch content body as text from a resource identified by [reference].
  ///
  /// Depending on the API the [reference] can be a relative path, an absolute
  /// URL, a key, or other identifier relevant on a context of an API.
  ///
  /// Throws an `ApiException` if fetching fails. Implementations like HTTP
  /// fetcher may also throw other status codes than codes for success as
  /// exceptions.
  Future<String> fetchText(Uri reference);

  /// Fetch content body as bytes from a resource identified by [reference].
  ///
  /// Depending on the API the [reference] can be a relative path, an absolute
  /// URL, a key, or other identifier relevant on a context of an API.
  ///
  /// Throws an `ApiException` if fetching fails. Implementations like HTTP
  /// fetcher may also throw other status codes than codes for success as
  /// exceptions.
  Future<Uint8List> fetchBytes(Uri reference);

  /// Fetch content body as JSON data from a resource identified by [reference].
  ///
  /// An optional [reviver] function is applied when decoding json string data.
  /// See `JsonCodec` of the `dart:convert` package for more information.
  ///
  /// Depending on the API the [reference] can be a relative path, an absolute
  /// URL, a key, or other identifier relevant on a context of an API.
  ///
  /// Throws an `ApiException` if fetching fails. Implementations like HTTP
  /// fetcher may also throw other status codes than codes for success as
  /// exceptions.
  Future<dynamic> fetchJson(
    Uri reference, {
    Object? Function(Object? key, Object? value)? reviver,
  });
}
