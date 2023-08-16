// Copyright (c) 2020-2023 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'package:meta/meta.dart';

import '/src/data.dart';

/// A helper utilility function used on `json.encode()`.
///
/// Not to be exported. Implementation may change in future.
@internal
Object? encodeJsonObject(
  dynamic object, {
  Object Function(DateTime time)? encodeTime,
}) {
  if (object is DataObjectView) {
    return object.toEncodable();
  } else if (object is DataArrayView) {
    return object.toEncodable();
  } else if (object is DateTime) {
    return encodeTime != null ? encodeTime(object) : object.toIso8601String();
  }

  // Fallback: just use toString() - works for Identifier, BigInt at least.
  return object.toString();
}
