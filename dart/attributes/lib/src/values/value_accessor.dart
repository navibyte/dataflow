// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'identifier.dart';
import 'primitive_accessor.dart';

/// An interface to access typed values by keys of type [K].
///
/// Normally [K] is either String or int, but could be other types also.
///
/// Implementations should support accessing at least following types: `String`,
/// `int`, `BigInt`, `double`, `bool`, `DateTime`, `Identifier` and `Null`.
abstract class ValueAccessor<K> extends PrimitiveAccessor<K> {
  const ValueAccessor();

  /// Returns a value at [key], the result can be of any object or null.
  ///
  /// FormatException is thrown if an underlying value is unavailable.
  Object? operator [](K key);

  /// Returns a value at [key] as `DateTime` in the UTC time zone.
  ///
  /// Use an optional [parse] function to define app specific conversion.
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be converted to DateTime.
  DateTime getTimeUTC(K key, {DateTime Function(Object?)? parse});

  /// Returns a value at [key] as [Identifier].
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be converted to Identifier.
  Identifier getId(K key);

  /// Returns a value at [key] as `DateTime` in the UTC time zone, or null.
  ///
  /// Use an optional [parse] function to define app specific conversion.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// converted to DateTime.
  DateTime? tryTimeUTC(K key, {DateTime Function(Object?)? parse});

  /// Returns a value at [key] as [Identifier] or null if missing.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// converted to Identifier.
  Identifier? tryId(K key);
}
