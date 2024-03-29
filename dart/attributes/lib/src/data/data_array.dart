// Copyright (c) 2020-2023 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

import '/src/exceptions.dart';
import '/src/utils/json/encode_utils.dart';
import '/src/values.dart';

import 'data_element.dart';
import 'data_object.dart';

/// An interface for a data array with property values accessed by `int` keys
/// (or indexes).
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
///
/// As this class is defined with the class modifier `interface`, the class can
/// only be implemented, but not extended. This class also provides factory
/// methods constructing instances of the default implementation provided by
/// [DataArrayView].
abstract interface class DataArray implements DataElement<int> {
  /// Creates a data array with items copied from [source].
  ///
  /// This is a factory creating an instance of [DataArrayView].
  factory DataArray.of([Iterable<Object?> source = const <Object>[]]) =>
      DataArrayView._ensureProtected(source);

  /// Creates a data array view backed by [source].
  ///
  /// This is a factory creating an instance of [DataArrayView].
  factory DataArray.view(Iterable<Object?> source) = DataArrayView._exposed;

  /// Creates a data array with items mapped from [source] list of [T].
  ///
  /// This is a factory creating an instance of [DataArrayView].
  static DataArray from<T extends Object>(
    Iterable<T> source,
    Object Function(T) convert,
  ) =>
      DataArrayView._protected(
        source.map<Object>(convert).toList(growable: false),
      );

  /// Creates a data array from [source] containing an encoded JSON Array.
  ///
  /// The underlying list is an object tree as parsed by the standard
  /// `json.decode()` of the `dart:convert` package.
  ///
  /// This is a factory creating an instance of [DataArrayView].
  factory DataArray.decodeJson(String source) =>
      DataArrayView._protected(json.decode(source) as Iterable<Object?>);

  /// Creates an empty data array.
  ///
  /// This is a factory creating an instance of [DataArrayView].
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

/// A base implemention of [DataArray] as a view of `Iterable<Object?>` source
/// data.
///
/// As this class is defined with the class modifier `base`, the class can
/// only be extended, but not implemented. When a subtype should be defined with
/// `implements`, then such a subtype should implement `DataArray`.
base class DataArrayView<Obj extends DataObject, Arr extends DataArray>
    with ValueAccessorMixin<int>, EquatableMixin
    implements DataArray {
  /// Creates a data array view wrapping a source [list].
  ///
  /// If [isExposed] is true, then [list] can be exposed to side effects.
  DataArrayView(this.list, {this.isExposed = false});

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

  /// Wrapped [list] containing values view by this class as [DataArray].
  @protected
  final Iterable<Object?> list;

  /// Whether [list] is (potentially) exposed to side effects.
  @protected
  final bool isExposed;

  @override
  List<Object?> get props => [list];

  @override
  String toString() => list.toString();

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
      throw const UndefinedValueException();
    }
    return list.elementAt(key);
  }

  @override
  Iterable<T> toValues<T extends Object>() =>
      toValuesOf<T>(list, isExposed: isExposed);

  @override
  Iterable<T?> toNullableValues<T extends Object>() =>
      toNullableValuesOf<T>(list, isExposed: isExposed);

  /// Returns data as an encodable object compatible with `json.encode()`.
  @Deprecated('Use toJson instead.')
  Iterable<Object?> toEncodable() => list;

  @override
  Iterable<Object?> toJson() => list;

  @override
  String encodeJson({Object Function(DateTime time)? encodeTime}) =>
      json.encode(
        toJson(),
        toEncodable: encodeTime != null
            ? (dynamic object) =>
                encodeJsonObject(object, encodeTime: encodeTime)
            : encodeJsonObject,
      );

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
  List<T> objectsToList<T extends Object>(
    T Function(Obj object) map, {
    int? limit,
  }) {
    var objs = objects;
    if (limit != null) {
      objs = objs.take(limit);
    }
    return objs.map<T>(map).toList(growable: false);
  }

  @override
  Iterable<Arr> get arrays =>
      list.where((e) => e is Arr || e is Iterable<Object?>).map(_toArray);

  @override
  List<T> arraysToList<T extends Object>(
    T Function(Arr array) map, {
    int? limit,
  }) {
    var arrs = arrays;
    if (limit != null) {
      arrs = arrs.take(limit);
    }
    return arrs.map<T>(map).toList(growable: false);
  }

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
