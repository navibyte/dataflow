// Copyright (c) 2020-2022 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'identifier.dart';
import 'primitive.dart';

/// A value with type and null safe accessors for data extending [Primitive].
///
/// Implementations should support accessing at least following types: `String`,
/// `int`, `BigInt`, `double`, `bool`, `DateTime`, `Identifier` and `Null`.
abstract class Value extends Primitive {
  /// Default `const` constructor to allow extending this abstract class.
  const Value();

  /// True if this value is stored as a `DateTime`.
  ///
  /// Even if false is returned it might be possible to access value as
  /// DateTime.
  bool get isDateTime;

  /// True if this value is stored as a `Identifier`.
  ///
  /// Even if false is returned it might be possible to access value as
  /// Identifier.
  bool get isId;

  /// This value as a `DateTime` value in the UTC time zone.
  ///
  /// Use an optional [parse] function to define app specific conversion.
  ///
  /// FormatException is thrown if an underlying value cannot be converted to
  /// DateTime in the UTC time zone.
  DateTime asTimeUTC({DateTime Function(Object?)? parse});

  /// This value as a `Identifier` value.
  ///
  /// FormatException is thrown if an underlying value cannot be converted to
  /// Identifier.
  Identifier asId();

  /// This value as a `DateTime` value (UTC) or null if cannot be converted.
  ///
  /// Use an optional [parse] function to define app specific conversion.
  DateTime? tryAsTimeUTC({DateTime Function(Object?)? parse});

  /// This value as a `Identifier` value or null if cannot be converted.
  Identifier? tryAsId();
}
