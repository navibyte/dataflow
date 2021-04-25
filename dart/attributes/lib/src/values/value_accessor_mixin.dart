// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import '../values.dart';

import 'value_accessor.dart';

/// A partial implementation of [ValueAccessor].
mixin ValueAccessorMixin<K> implements ValueAccessor<K> {
  @override
  bool existsNull(K key) => exists(key) && this[key] == null;

  @override
  bool existsNonNull(K key) => exists(key) && this[key] != null;

  @override
  String getString(K key) => valueToString(this[key]);

  @override
  int getInt(K key, {int? min, int? max}) =>
      valueToInt(this[key], min: min, max: max);

  @override
  BigInt getBigInt(K key, {BigInt? min, BigInt? max}) =>
      valueToBigInt(this[key], min: min, max: max);

  @override
  double getDouble(K key, {double? min, double? max}) =>
      valueToDouble(this[key], min: min, max: max);

  @override
  num getNum(K key, {num? min, num? max}) =>
      valueToNum(this[key], min: min, max: max);

  @override
  bool getBool(K key) => valueToBool(this[key]);

  @override
  DateTime getTimeUTC(K key, {DateTime Function(Object?)? parse}) =>
      parse != null ? parse(this[key]).toUtc() : valueToTimeUTC(this[key]);

  @override
  String? tryString(K key) {
    try {
      return getString(key);
    } on Exception {
      return null;
    }
  }

  @override
  int? tryInt(K key, {int? min, int? max}) {
    try {
      return getInt(key, min: min, max: max);
    } on Exception {
      return null;
    }
  }

  @override
  BigInt? tryBigInt(K key, {BigInt? min, BigInt? max}) {
    try {
      return getBigInt(key, min: min, max: max);
    } on Exception {
      return null;
    }
  }

  @override
  double? tryDouble(K key, {double? min, double? max}) {
    try {
      return getDouble(key, min: min, max: max);
    } on Exception {
      return null;
    }
  }

  @override
  num? tryNum(K key, {num? min, num? max}) {
    try {
      return getNum(key, min: min, max: max);
    } on Exception {
      return null;
    }
  }

  @override
  bool? tryBool(K key) {
    try {
      return getBool(key);
    } on Exception {
      return null;
    }
  }

  @override
  DateTime? tryTimeUTC(K key, {DateTime Function(Object?)? parse}) {
    try {
      return getTimeUTC(key, parse: parse);
    } on Exception {
      return null;
    }
  }
}
