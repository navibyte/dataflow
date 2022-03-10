// Copyright (c) 2020-2022 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'package:intl/intl.dart';

import '/src/exceptions.dart';

import 'identifier.dart';

/// Converts [data] to `String` or throws FormatException if cannot convert.
String toStringValue(Object? data) {
  if (data == null) throw const NullValueException();
  if (data is String) return data;
  return data.toString();
}

/// Converts [data] to `int` or throws FormatException if cannot convert.
///
/// If provided [min] and [max] are used to clamp the returned value.
int toIntValue(Object? data, {int? min, int? max}) {
  if (data == null) throw const NullValueException();
  int result;
  if (data is num) {
    result = data.round();
  } else if (data is BigInt) {
    result = data.toInt();
  } else if (data is String) {
    result = _stringToInt(data);
  } else if (data is bool) {
    result = data ? 1 : 0;
  } else {
    throw ConversionException(target: int, data: data);
  }
  if (min != null && result < min) {
    result = min;
  }
  if (max != null && result > max) {
    result = max;
  }
  return result;
}

/// Converts [data] to `BigInt` or throws FormatException if cannot convert.
///
/// If provided [min] and [max] are used to clamp the returned value.
BigInt toBigIntValue(Object? data, {BigInt? min, BigInt? max}) {
  if (data == null) throw const NullValueException();
  BigInt result;
  if (data is BigInt) {
    result = data;
  } else if (data is num) {
    result = BigInt.from(data);
  } else if (data is String) {
    result = BigInt.parse(data);
  } else if (data is bool) {
    result = data ? BigInt.one : BigInt.zero;
  } else {
    throw ConversionException(target: BigInt, data: data);
  }
  if (min != null && result < min) {
    result = min;
  }
  if (max != null && result > max) {
    result = max;
  }
  return result;
}

/// Converts [data] to `double` or throws FormatException if cannot convert.
///
/// If provided [min] and [max] are used to clamp the returned value.
double toDoubleValue(Object? data, {double? min, double? max}) {
  if (data == null) throw const NullValueException();
  double result;
  if (data is num) {
    result = data.toDouble();
  } else if (data is BigInt) {
    result = data.toDouble();
  } else if (data is String) {
    result = double.parse(data);
  } else if (data is bool) {
    result = data ? 1.0 : 0.0;
  } else {
    throw ConversionException(target: double, data: data);
  }
  if (min != null && result < min) {
    result = min;
  }
  if (max != null && result > max) {
    result = max;
  }
  return result;
}

/// Converts [data] to `num` or throws FormatException if cannot convert.
///
/// Returned value is either `int` or `double` that implement `num`.
///
/// If provided [min] and [max] are used to clamp the returned value.
num toNumValue(Object? data, {num? min, num? max}) {
  if (data == null) throw const NullValueException();
  num result;
  if (data is num) {
    result = data;
  } else if (data is BigInt) {
    result = data.isValidInt ? data.toInt() : data.toDouble();
  } else if (data is String) {
    // first try to parse as int, otherwise as double, and if that fails throws
    result = int.tryParse(data) ?? double.parse(data);
  } else if (data is bool) {
    result = data ? 1 : 0;
  } else {
    throw ConversionException(target: num, data: data);
  }
  if (min != null && result < min) {
    result = min;
  }
  if (max != null && result > max) {
    result = max;
  }
  return result;
}

/// Converts [data] to `bool` or throws FormatException if cannot convert.
bool toBoolValue(Object? data) {
  if (data == null) throw const NullValueException();
  if (data is bool) {
    return data;
  } else if (data is num) {
    return data.round() != 0;
  } else if (data is BigInt) {
    return data.toInt() != 0;
  } else if (data is String) {
    switch (data) {
      case '':
      case 'false':
      case '0':
        return false;
      case 'true':
      case '1':
        return true;
    }
  }
  throw ConversionException(target: bool, data: data);
}

/// Converts the [data] to a `DateTime` value.
///
/// The returned time is ensured to be in the UTC time zone.
///
/// If the [data] is already a `DateTime` then it is returned (UTC ensured).
///
/// If the [data] is String then DateTime.parse is used in parsing. Or if
/// [sourceFormat] (and optionally [isUTCSource] too) is given, then that format
/// instance is used in parsing.
///
/// Otherwise a FormatException is thrown.
DateTime toTimeUTCValue(
  Object? data, {
  DateFormat? sourceFormat,
  bool isUTCSource = false,
}) {
  if (data == null) throw const NullValueException();
  if (data is DateTime) {
    return data.toUtc();
  } else if (data is String) {
    if (sourceFormat == null) {
      // "The function parses a subset of ISO 8601 which includes the subset
      // accepted by RFC 3339."
      return DateTime.parse(data).toUtc();
    } else {
      return sourceFormat.parse(data, isUTCSource).toUtc();
    }
  }
  throw ConversionException(target: DateTime, data: data);
}

/// Converts the [data] to a `DateTime` value.
///
/// The returned time is ensured to be in the UTC time zone.
///
/// If the [data] is already a `DateTime` then it is returned (UTC ensured).
///
/// If the [data] is int then
/// DateTime.fromMillisecondsSinceEpoch is used in parsing.
///
/// If the [data] is String then it is parsed to int and
/// DateTime.fromMillisecondsSinceEpoch is used in parsing.
///
/// Otherwise a FormatException is thrown.
DateTime toTimeMillisUTCValue(Object? data, {bool isUTCSource = false}) {
  if (data == null) throw const NullValueException();
  if (data is DateTime) {
    return data.toUtc();
  } else if (data is int) {
    return DateTime.fromMillisecondsSinceEpoch(data, isUtc: isUTCSource)
        .toUtc();
  } else if (data is String) {
    return DateTime.fromMillisecondsSinceEpoch(
      int.parse(data),
      isUtc: isUTCSource,
    ).toUtc();
  }
  throw ConversionException(target: DateTime, data: data);
}

/// Converts [data] to [Identifier] or throws FormatException if cannot convert.
Identifier toIdValue(Object? data) {
  if (data == null) throw const NullValueException();
  if (data is Identifier) {
    return data;
  } else {
    return Identifier.from(data);
  }
}

/// Converts [data] to a value of [T] or throws FormatException if cannot.
///
/// Supported types for [T]: `String`, `num`, `int`, `BigInt`, `double`,
/// `bool`, `DateTime`, `Identifier`, `Object`.
T toValueOf<T extends Object>(Object? data) {
  if (data == null) {
    throw const NullValueException();
  } else if (T == String) {
    return toStringValue(data) as T;
  } else if (T == num) {
    return toNumValue(data) as T;
  } else if (T == int) {
    return toIntValue(data) as T;
  } else if (T == BigInt) {
    return toBigIntValue(data) as T;
  } else if (T == double) {
    return toDoubleValue(data) as T;
  } else if (T == bool) {
    return toBoolValue(data) as T;
  } else if (T == DateTime) {
    return toTimeUTCValue(data) as T;
  } else if (T == Identifier) {
    return toIdValue(data) as T;
  } else if (T == Object) {
    return data as T;
  }
  throw ConversionException(data: data, target: T);
}

/// Converts [data] to a value of `T?` or throws if cannot convert.
///
/// Supported types for [T]: `String`, `num`, `int`, `BigInt`, `double`,
/// `bool`, `DateTime`, `Identifier`, `Object`.
T? toNullableValueOf<T extends Object>(Object? data) =>
    data == null ? null : toValueOf<T>(data);

/// Converts [list] to a value iterable of [T] or throws if cannot convert.
///
/// The returned iterable cannot contain null values.
///
/// Supported types for [T]: `String`, `num`, `int`, `BigInt`, `double`,
/// `bool`, `DateTime`, `Identifier`, `Object`.
Iterable<T> toValuesOf<T extends Object>(
  Iterable<Object?> list, {
  bool isExposed = false,
}) {
  if (list is Iterable<T>) {
    // value is an iterable with items of the asked type
    return isExposed ? List<T>.unmodifiable(list) : list;
  } else {
    // value is an iterable with items of any type
    if (T == Object) {
      // requesting Iterable<Object>
      return isExposed ? List<T>.unmodifiable(list) : list.cast<T>();
    } else {
      // requesting more specific types than Object, map items to T
      return list.map<T>((dynamic e) => toValueOf<T>(e));
    }
  }
}

/// Converts [list] to a value iterable of `T?` or throws if cannot convert.
///
/// The returned iterable may contain null values.
///
/// Supported types for [T]: `String`, `num`, `int`, `BigInt`, `double`,
/// `bool`, `DateTime`, `Identifier`, `Object`.
Iterable<T?> toNullableValuesOf<T extends Object>(
  Iterable<Object?> list, {
  bool isExposed = false,
}) {
  if (list is Iterable<T?>) {
    // value is an iterable with items of the asked type
    return isExposed ? List<T?>.unmodifiable(list) : list;
  } else if (list is Iterable<T>) {
    // value is an iterable with items of non-nullable type of the asked type
    return isExposed ? List<T?>.unmodifiable(list) : list.cast<T?>();
  } else {
    // value is an iterable with items of any type
    if (T == Object) {
      // requesting Iterable<Object?>
      return isExposed ? List<T?>.unmodifiable(list) : list.cast<T?>();
    } else {
      // requesting more specific types than Object?, map items to T?
      return list.map<T?>((dynamic e) => toNullableValueOf<T>(e));
    }
  }
}

/// Converts [map] to a value map of [K] to [V], or throws if cannot convert.
///
/// The returned map cannot contain null values.
///
/// Supported types for [V]: `String`, `num`, `int`, `BigInt`, `double`,
/// `bool`, `DateTime`, `Identifier`, `Object`.
Map<K, V> toValueMapOf<K extends Object, V extends Object>(
  Map<K, Object?> map, {
  bool isExposed = false,
}) {
  if (map is Map<K, V>) {
    return isExposed ? Map<K, V>.unmodifiable(map) : map;
  } else {
    return map
        .map<K, V>((key, value) => MapEntry<K, V>(key, toValueOf<V>(value)));
  }
}

/// Converts [map] to a value map of [K] to `V?`, or throws if cannot convert.
///
/// The returned map may contain null values.
///
/// Supported types for [V]: `String`, `num`, `int`, `BigInt`, `double`,
/// `bool`, `DateTime`, `Identifier`, `Object`.
Map<K, V?> toNullableValueMapOf<K extends Object, V extends Object>(
  Map<K, Object?> map, {
  bool isExposed = false,
}) {
  if (map is Map<K, V?>) {
    return isExposed ? Map<K, V?>.unmodifiable(map) : map;
  } else if (map is Map<K, V>) {
    return isExposed ? Map<K, V?>.unmodifiable(map) : map.cast<K, V?>();
  } else {
    return map.map<K, V?>(
      (key, value) => MapEntry<K, V?>(key, toNullableValueOf<V>(value)),
    );
  }
}

int _stringToInt(String value) =>
    int.tryParse(value) ?? double.parse(value).round();
