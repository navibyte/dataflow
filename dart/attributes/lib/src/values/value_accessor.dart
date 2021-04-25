// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

/// An interface to access typed values by keys of type [K].
///
/// Normally [K] is either String or int, but could be other types also.
///
/// Implementations should support accessing at least following types:
///  `String`, `int`, `BigInt`, `double`, `bool`, `DateTime` and `Null`.
abstract class ValueAccessor<K> {
  const ValueAccessor();

  /// Returns true if the [key] references an existing value, null or non-null.
  bool exists(K key);

  /// Returns true if a value with [key] exists and that value is null.
  bool existsNull(K key);

  /// Returns true if a value with [key] exists and that value is non-null.
  bool existsNonNull(K key);

  /// Returns a value at [key], the result can be of any object or null.
  ///
  /// FormatException is thrown if an underlying value is unavailable.
  Object? operator [](K key);

  /// Returns a value of `String` type at [key].
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be converted to String.
  String getString(K key);

  /// Returns a value of `int` type at [key].
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be converted to int.
  int getInt(K key, {int? min, int? max});

  /// Returns a value of `BigInt` type at [key].
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be converted to BigInt.
  BigInt getBigInt(K key, {BigInt? min, BigInt? max});

  /// Returns a value of `double` type at [key].
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be converted to double.
  double getDouble(K key, {double? min, double? max});

  /// Returns a value of `num` type at [key].
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be converted to num.
  num getNum(K key, {num? min, num? max});

  /// Returns a value of `bool` type at [key].
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be converted to bool.
  bool getBool(K key);

  /// Returns a located at [key] as a `DateTime` value of UTC.
  ///
  /// Use an optional [parse] function to define app specific conversion.
  ///
  /// The returned time must be in the UTC time zone.
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be converted to DateTime.
  DateTime getTimeUTC(K key, {DateTime Function(Object?)? parse});

  /// Returns a value of `String` type at [key] or null if missing.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// converted to String.
  String? tryString(K key);

  /// Returns a value of `int` type at [key] or null if missing.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// converted to int.
  int? tryInt(K key, {int? min, int? max});

  /// Returns a value of `BigInt` type at [key] or null if missing.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// converted to BigInt.
  BigInt? tryBigInt(K key, {BigInt? min, BigInt? max});

  /// Returns a value of `double` type at [key] or null if missing.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// converted to double.
  double? tryDouble(K key, {double? min, double? max});

  /// Returns a value of `num` type at [key] or null if missing.
  ///
  /// If provided [min] and [max] are used to clamp the returned value.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// converted to num.
  num? tryNum(K key, {num? min, num? max});

  /// Returns a value of `bool` type at [key] or null if missing.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// converted to bool.
  bool? tryBool(K key);

  /// Returns a value located at [key] as a `DateTime` value of UTC or null.
  ///
  /// Use an optional [parse] function to define app specific conversion.
  ///
  /// The returned time must be in the UTC time zone.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// converted to DateTime.
  DateTime? tryTimeUTC(K key, {DateTime Function(Object?)? parse});
}
