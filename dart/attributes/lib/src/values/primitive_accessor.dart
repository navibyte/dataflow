// Copyright (c) 2020-2022 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

/// An interface to access typed primitive values by keys of type [K].
///
/// Normally [K] is either String or int, but could be other types also.
///
/// Implementations should support accessing at least following types: `String`,
/// `int`, `BigInt`, `double`, `bool` and `Null`.
abstract class PrimitiveAccessor<K> {
  /// Default `const` constructor to allow extending this abstract class.
  const PrimitiveAccessor();

  /// Returns true if the [key] references an existing value, null or non-null.
  bool exists(K key);

  /// Returns true if a value at [key] exists and that value is null.
  bool existsNull(K key);

  /// Returns true if a value at [key] exists and that value is non-null.
  bool existsNonNull(K key);

  /// Returns a value at [key] as `String`.
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be converted to String.
  String getString(K key);

  /// Returns a value at [key] as `int`.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be converted to int.
  int getInt(K key, {int? min, int? max});

  /// Returns a value at [key] as `BigInt`.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be converted to BigInt.
  BigInt getBigInt(K key, {BigInt? min, BigInt? max});

  /// Returns a value at [key] as `double`.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be converted to double.
  double getDouble(K key, {double? min, double? max});

  /// Returns a value at [key] as `num`.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be converted to num.
  num getNum(K key, {num? min, num? max});

  /// Returns a value at [key] as `bool`.
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be converted to bool.
  bool getBool(K key);

  /// Returns a value at [key] as `String` or null if missing.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// converted to String.
  String? tryString(K key);

  /// Returns a value at [key] as `int` or null if missing.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// converted to int.
  int? tryInt(K key, {int? min, int? max});

  /// Returns a value at [key] as `BigInt` or null if missing.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// converted to BigInt.
  BigInt? tryBigInt(K key, {BigInt? min, BigInt? max});

  /// Returns a value at [key] as `double` or null if missing.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// converted to double.
  double? tryDouble(K key, {double? min, double? max});

  /// Returns a value at [key] as `num` or null if missing.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// converted to num.
  num? tryNum(K key, {num? min, num? max});

  /// Returns a value at [key] as `bool` or null if missing.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// converted to bool.
  bool? tryBool(K key);
}
