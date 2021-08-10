// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';

import '../utils/json.dart';

import '../exceptions.dart';
import '../values.dart';

import 'data_element.dart';
import 'data_object.dart';

/// A data array with property values accessed by `int` keys (or indexes).
///
/// See samples below to create a copied data array, a view wrapping an
/// instance of the standard `Iterable`, and decoding one from JSON.
///
/// ```dart
/// final copied = DataArray.of(['foo', 'bar', 2, null]);
///
/// final list = ['foo', 'bar', 2, null];
/// final view = DataArray.view(list);
///
/// final json = DataArray.decodeJson('["foo", "bar", 2, null]');
/// ```
abstract class DataArray extends DataElement<int> {
  const DataArray();

  /// Creates a data array with items copied from [source].
  factory DataArray.of([Iterable<Object?> source = const <Object>[]]) =>
      DataArrayView._ensureProtected(source);

  /// Creates a data array view backed by [source].
  factory DataArray.view(Iterable<Object?> source) = DataArrayView._exposed;

  /// Creates a data array from [source] containing an encoded JSON Array.
  ///
  /// The underlying list is an object tree as parsed by the standard
  /// `json.decode()` of the `dart:convert` package.
  factory DataArray.decodeJson(String source) =>
      DataArrayView._protected(json.decode(source) as Iterable<Object?>);

  /// Creates an empty data array.
  factory DataArray.empty() => _empty;

  static final DataArray _empty = DataArrayView._protected(const <Object>[]);

  /// Returns all values as an iterable of [T].
  ///
  /// Throws FormatException if a value cannot be represented as `T`.
  Iterable<T> toValues<T extends Object>();

  /// Returns all values as an iterable of `T?`.
  ///
  /// Throws FormatException if a value cannot be represented as `T?`.
  Iterable<T?> toNullableValues<T extends Object>();
}

/// A [DataArray] implemention as a view of `Iterable<Object?>` source data.
class DataArrayView<Obj extends DataObject, Arr extends DataArray>
    with ValueAccessorMixin<int>, EquatableMixin
    implements DataArray {
  /// Creates a data array view wrapping a source [list].
  ///
  /// If [isExposed] is true, then [list] can be exposed to side effects.
  const DataArrayView(this.list, {this.isExposed = false});

  /// The [source] could be exposed to other code, potentially mutable.
  DataArrayView._exposed(Iterable<Object?> source)
      : this(source, isExposed: true);

  /// The [source] is created locally without exposing a reference, instance
  /// itself can be mutable, but no one can actually mutate it, so "protected".
  DataArrayView._protected(Iterable<Object?> source)
      : this(source, isExposed: false);

  /// The [source] might be exposed, but want to protect data from mutations.
  DataArrayView._ensureProtected(Iterable<Object?> source)
      : this(source.toList(growable: false), isExposed: false);

  /// Do not use directly, only from sub classes (marked @protected).
  ///
  /// Delegates to `_exposed(Iterable<Object?> source)` factory.
  /// Should be overridden on sub classes.
  @protected
  Arr newExposed(Iterable<Object?> source) =>
      DataArrayView._exposed(source) as Arr;

  /// Do not use directly, only from sub classes (marked @protected).
  ///
  /// Delegates to `_protected(Iterable<Object?> source)` factory.
  /// Should be overridden on sub classes.
  @protected
  Arr newProtected(Iterable<Object?> source) =>
      DataArrayView._protected(source) as Arr;

  /// Do not use directly, only from sub classes (marked @protected).
  ///
  /// Delegates to `_ensureProtected(Iterable<Object?> source)` factory.
  /// Should be overridden on sub classes.
  @protected
  Arr newEnsureProtected(Iterable<Object?> source) =>
      DataArrayView._ensureProtected(source) as Arr;

  /// Do not use directly, only from sub classes (marked @protected).
  ///
  /// Delegates to `DataObject.view(Map<String, Object?> source)` factory.
  /// Should be overridden on sub classes.
  @protected
  Obj newObjectView(Map<String, Object?> source) =>
      DataObject.view(source) as Obj;

  @protected
  final Iterable<Object?> list;

  @protected
  final bool isExposed;

  @override
  List<Object?> get props => [list];

  @override
  int get length => list.length;

  @override
  bool get isEmpty => list.isEmpty;

  @override
  bool get isNotEmpty => list.isNotEmpty;

  @override
  bool exists(int key) => key >= 0 && key < length;

  @override
  Object? operator [](int key) => _checkAt(key);

  Object? _checkAt(int key) {
    if (key < 0 && key >= length) {
      throw UndefinedValueException();
    }
    return list.elementAt(key);
  }

  @override
  Iterable<T> toValues<T extends Object>() =>
      toValuesOf<T>(list, isExposed: isExposed);

  @override
  Iterable<T?> toNullableValues<T extends Object>() =>
      toNullableValuesOf<T>(list, isExposed: isExposed);

  Object? toEncodable() => list;

  @override
  String encodeJson({Object Function(DateTime time)? encodeTime}) =>
      json.encode(toEncodable(),
          toEncodable: encodeTime != null
              ? (dynamic object) =>
                  encodeJsonObject(object, encodeTime: encodeTime)
              : encodeJsonObject);

  @override
  Obj object(int key) => _toObject(this[key]);

  @override
  Obj? tryObject(int key) {
    try {
      return object(key);
    } on Exception {
      return null;
    }
  }

  @override
  Arr array(int key) => _toArray(this[key]);

  @override
  Arr? tryArray(int key) {
    try {
      return array(key);
    } on Exception {
      return null;
    }
  }

  @override
  Iterable<Obj> get objects =>
      list.where((e) => e is Obj || e is Map<String, Object?>).map(_toObject);

  @override
  Iterable<Arr> get arrays =>
      list.where((e) => e is Arr || e is Iterable<Object?>).map(_toArray);

  Obj _toObject(Object? e) {
    if (e is Obj) {
      return e;
    } else if (e is Map<String, Object?>) {
      return newObjectView(e);
    }
    throw ConversionException(target: Obj, data: e);
  }

  Arr _toArray(Object? e) {
    if (e is Arr) {
      return e;
    } else if (e is Iterable<Object?>) {
      return newExposed(e);
    }
    throw ConversionException(target: Arr, data: e);
  }
}
