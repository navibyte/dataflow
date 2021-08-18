// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'dart:typed_data';

import '../exceptions.dart' show ClientException;

/// An interface for accessing content body as String, bytes or JSON objects.
abstract class Body {
  /// Default `const` constructor to allow extending this abstract class.
  const Body();

  /// Reads content body as text and returns a future of String.
  Future<String> get text;

  /// Reads content body as bytes and returns a future of Uint8List.
  Future<Uint8List> get bytes;

  /// Reads content body as bytes and returns a future of ByteData.
  ///
  /// Optional [start] and [end] parameters define a range to be read. It's
  /// required that `0 ≤ start ≤ end ≤ contentLength`. See also
  /// `ByteData.sublistView` for reference.
  Future<ByteData> byteData([int start = 0, int? end]);

  /// Returns content body as a single-subscription byte stream.
  Stream<List<int>> byteStream();

  /// Reads and decodes content body as a JSON object, returned in a future.
  ///
  /// The result is an object tree as parsed by the standard `json.decode()` of
  /// the `dart:convert` package.
  ///
  /// An optional [reviver] function is applied when decoding json string data.
  /// See `JsonCodec` of the `dart:convert` package for more information.
  ///
  /// Throws [ClientException] if content body cannot be decoded as JSON.
  Future<dynamic> decodeJson(
      {Object? Function(Object? key, Object? value)? reviver});
}
