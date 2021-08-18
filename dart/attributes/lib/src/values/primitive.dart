// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'string_or_integer.dart';

/// A primitive value with type and null safe accessors for data.
///
/// Implementations should support accessing at least following types: `String`,
/// `int`, `BigInt`, `double`, `bool` and `Null`.
abstract class Primitive extends StringOrInteger {
  /// Default `const` constructor to allow extending this abstract class.
  const Primitive();

  /// True if this value is stored as numeric (`int`, `BigInt`, `double`) value.
  ///
  /// Even if false is returned it might be possible to access value as number.
  bool get isNumeric;

  /// True if this value is stored as a `double`.
  ///
  /// Even if false is returned it might be possible to access value as double.
  bool get isDouble;

  /// True if this value is stored as a `bool`.
  ///
  /// Even if false is returned it might be possible to access value as bool.
  bool get isBool;

  /// True if the stored value is a `null` object.
  bool get isNull;

  /// Returns this value as a `int` value.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// FormatException is thrown if an underlying value cannot be converted to
  /// int.
  ///
  /// On web enviroment (compiled with dart2js) `int` can store "all integers
  /// between -2^53 and 2^53, and some integers with larger magnitude".
  @override
  int asInt({int? min, int? max});

  /// Returns this value as a `BigInt` value.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// FormatException is thrown if an underlying value cannot be converted to
  /// BigInt.
  @override
  BigInt asBigInt({BigInt? min, BigInt? max});

  /// This value as a `double` value.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// FormatException is thrown if an underlying value cannot be converted to
  /// double.
  double asDouble({double? min, double? max});

  /// This value as a `num` value (either `double` or `int`).
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// FormatException is thrown if an underlying value cannot be converted to
  /// num.
  num asNum({num? min, num? max});

  /// This value as a `bool` value.
  ///
  /// FormatException is thrown if an underlying value cannot be converted to
  /// bool.
  bool asBool();

  /// This value as a `int` value or null if cannot be converted to `int`.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// On web enviroment (compiled with dart2js) `int` can store "all integers
  /// between -2^53 and 2^53, and some integers with larger magnitude".
  @override
  int? tryAsInt({int? min, int? max});

  /// This value as a `BigInt` value or null if cannot be converted to `BigInt`.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  @override
  BigInt? tryAsBigInt({BigInt? min, BigInt? max});

  /// This value as a `double` or null if cannot be converted to `double`.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  double? tryAsDouble({double? min, double? max});

  /// This value as a `num` or null if cannot be converted to `num`.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  num? tryAsNum({num? min, num? max});

  /// This value as a `bool` or null if cannot be converted to `bool`.
  bool? tryAsBool();
}
