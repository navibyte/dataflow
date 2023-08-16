// Copyright (c) 2020-2022 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'package:meta/meta.dart';

import 'string_or_integer.dart';

/// An interface for an identifier of something, represented as `String`, `int`
/// or `BigInt`.
///
/// As this class is defined with the class modifier `interface`, the class can
/// only be implemented, but not extended. This class also provides a default
/// implementation that allows constructing instaces of [Identifier].
@immutable
interface class Identifier implements StringOrInteger {
  /// The stored id as a `String`, `int` or `BigInt` value.
  final Object _storage;

  const Identifier._(this._storage)
      : assert(
          _storage is String || _storage is int || _storage is BigInt,
          'Wrong type for an identifier.',
        );

  /// An identifier from [id] that MUST be either `String`, `int` or `BigInt`.
  ///
  /// Please note that for production runtimes the id is not validated even if
  /// for development environment assertions apply checking for correct types.
  ///
  /// You may want to use `fromString`, `fromInt` or `fromBigInt` to ensure
  /// better type safety if id type is known statically.
  ///
  /// This constructor creates an instance of the default implementation of
  /// [Identifier].
  const Identifier.from(Object id) : this._(id);

  /// An identifier from [id] of the type `String`.
  ///
  /// This constructor creates an instance of the default implementation of
  /// [Identifier].
  const Identifier.fromString(String id) : this._(id);

  /// An identifier from [id] of the type `int`.
  ///
  /// On web enviroment (compiled with dart2js) `int` can store "all integers
  /// between -2^53 and 2^53, and some integers with larger magnitude".
  ///
  /// This constructor creates an instance of the default implementation of
  /// [Identifier].
  const Identifier.fromInt(int id) : this._(id);

  /// An identifier from [id] of the type `BigInt`.
  ///
  /// This constructor creates an instance of the default implementation of
  /// [Identifier].
  const Identifier.fromBigInt(BigInt id) : this._(id);

  /// Prepares a nullable [Identifier] instance of the given [id].
  ///
  /// The [id] argument is allowed to be null or an instance of [Identifier],
  /// `String`, `int` or `BigInt`. In other cases an ArgumentError is thrown.
  static Identifier? idOrNull(Object? id) {
    if (id == null) {
      return null;
    } else if (id is Identifier) {
      return id;
    } else {
      return Identifier.from(id);
    }
  }

  @override
  bool get isString => _storage is String;

  @override
  bool get isInteger => _storage is BigInt || _storage is int;

  @override
  bool get isInt => _storage is int;

  @override
  bool get isBigInt => _storage is BigInt;

  @override
  String asString() => _storage.toString();

  @override
  int asInt() {
    final id = _storage;
    if (id is int) {
      return id;
    } else if (id is BigInt) {
      final clamped = id.toInt();
      if (id != BigInt.from(clamped)) {
        throw FormatException('$id cannot be clamped to int');
      }
      return clamped;
    } else {
      return int.parse(id.toString());
    }
  }

  @override
  BigInt asBigInt() {
    final id = _storage;
    if (id is BigInt) {
      return id;
    } else if (id is int) {
      return BigInt.from(id);
    } else {
      return BigInt.parse(id.toString());
    }
  }

  @override
  String? tryAsString() {
    try {
      return asString();
    } on Exception {
      return null;
    }
  }

  @override
  int? tryAsInt() {
    try {
      return asInt();
    } on Exception {
      return null;
    }
  }

  @override
  BigInt? tryAsBigInt() {
    try {
      return asBigInt();
    } on Exception {
      return null;
    }
  }

  @override
  String toString() => _storage.toString();

  @override
  bool operator ==(Object other) =>
      other is Identifier &&
      other.runtimeType == Identifier &&
      _storage == other._storage;

  @override
  int get hashCode => _storage.hashCode;
}
