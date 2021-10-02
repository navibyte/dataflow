// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

import '../exceptions.dart';
import '../utils/json.dart';
import '../values.dart';

import 'data_array.dart';
import 'data_element.dart';

/// A data object with property values accessed by `String` keys.
///
/// See samples below to create a copied data object, a view wrapping an
/// instance of the standard `Map`, and decoding one from JSON.
///
/// ```dart
/// final copied = DataObject.of({'foo': 1, 'bar': 'two'});
///
/// final map = {'foo': 1, 'bar': 'two', 'other', null};
/// final view = DataObject.view(map);
///
/// final json = DataObject.decodeJson('{"foo": 1, "bar": "two"}');
/// ```
abstract class DataObject extends DataElement<String> {
  /// Default `const` constructor to allow extending this abstract class.
  const DataObject();

  /// Creates a data object with items copied from [source].
  factory DataObject.of([Map<String, Object?> source = const {}]) =>
      DataObjectView<DataObject, DataArray>._ensureProtected(source);

  /// Creates a data object view backed by [source].
  factory DataObject.view(Map<String, Object?> source) =
      DataObjectView<DataObject, DataArray>._exposed;

  /// Creates a data object with items mapped from [source] of [K] - [V] pairs.
  static DataObject from<K extends Object, V extends Object>(
          Map<K, V> source, MapEntry<String, Object> Function(K, V) convert) =>
      DataObjectView._protected(source.map<String, Object>(convert));

  /// Creates a data object from [source] containing an encoded JSON Object.
  ///
  /// The underlying map is an object tree as parsed by the standard
  /// `json.decode()` of the `dart:convert` package.
  factory DataObject.decodeJson(String source) =>
      DataObjectView<DataObject, DataArray>._protected(
          json.decode(source) as Map<String, Object?>);

  /// Creates an empty data object.
  factory DataObject.empty() => _empty;

  static final _empty =
      DataObjectView<DataObject, DataArray>._protected(const {});

  /// Returns map [keys].
  Iterable<String> get keys;

  /// Returns map items (key-value pairs) with values represented as [T].
  ///
  /// Throws FormatException if a value cannot be represented as `T`.
  Map<String, T> toValueMap<T extends Object>();

  /// Returns map items (key-value pairs) with values represented as `T?`.
  ///
  /// Throws FormatException if a value cannot be represented as `T?`.
  Map<String, T?> toNullableValueMap<T extends Object>();
}

/// A [DataObject] implemention as a view of `Map<String, Object?>` source data.
class DataObjectView<Obj extends DataObject, Arr extends DataArray>
    with ValueAccessorMixin<String>, EquatableMixin
    implements DataObject {
  /// Creates a data object view wrapping a source [map].
  ///
  /// If [isExposed] is true, then [map] can be exposed to side effects.
  const DataObjectView(this.map, {this.isExposed = false});

  /// The [source] could be exposed to other code, potentially mutable.
  DataObjectView._exposed(Map<String, Object?> source)
      : this(source, isExposed: true);

  /// The [source] is created locally without exposing a reference, instance
  /// itself can be mutable, but no one can actually mutate it, so "protected".
  DataObjectView._protected(Map<String, Object?> source)
      : this(source, isExposed: false);

  /// The [source] might be exposed, but want to protect data from mutations.
  DataObjectView._ensureProtected(Map<String, Object?> source)
      : this(Map<String, Object?>.unmodifiable(source), isExposed: false);

  /// Do not use directly, only from sub classes (marked @protected).
  ///
  /// Delegates to `_exposed(Map<String, Object?> source)` factory.
  /// Should be overridden on sub classes.
  @protected
  Obj newExposed(Map<String, Object?> source) =>
      DataObjectView._exposed(source) as Obj;

  /// Do not use directly, only from sub classes (marked @protected).
  ///
  /// Delegates to `_protected(Map<String, Object?> source)` factory.
  /// Should be overridden on sub classes.
  @protected
  Obj newProtected(Map<String, Object?> source) =>
      DataObjectView._protected(source) as Obj;

  /// Do not use directly, only from sub classes (marked @protected).
  ///
  /// Delegates to `_ensureProtected(Map<String, Object?> source)` factory.
  /// Should be overridden on sub classes.
  @protected
  Obj newEnsureProtected(Map<String, Object?> source) =>
      DataObjectView._ensureProtected(source) as Obj;

  /// Do not use directly, only from sub classes (marked @protected).
  ///
  /// Delegates to `DataArray.view(Iterable<Object?> source)` factory.
  /// Should be overridden on sub classes.
  @protected
  Arr newArrayView(Iterable<Object?> source) => DataArray.view(source) as Arr;

  /// Wrapped [map] containing map entries view by this class as [DataObject].
  @protected
  final Map<String, Object?> map;

  /// Whether [map] is (potentially) exposed to side effects.
  @protected
  final bool isExposed;

  @override
  List<Object?> get props => [map];

  @override
  int get length => map.length;

  @override
  bool get isEmpty => map.isEmpty;

  @override
  bool get isNotEmpty => map.isNotEmpty;

  @override
  bool exists(String key) => keys.contains(key);

  @override
  Iterable<String> get keys => map.keys;

  Object? _checkAt(String key) {
    final value = map[key];
    if (value == null) {
      if (!exists(key)) {
        throw const UndefinedValueException();
      }
    }
    return value;
  }

  @override
  Object? operator [](String key) => _checkAt(key);

  @override
  Map<String, T> toValueMap<T extends Object>() =>
      toValueMapOf<String, T>(map, isExposed: isExposed);

  @override
  Map<String, T?> toNullableValueMap<T extends Object>() =>
      toNullableValueMapOf<String, T>(map, isExposed: isExposed);

  /// Returns data as an encodable object compatible with `json.encode()`.
  Object? toEncodable() => map;

  @override
  String encodeJson({Object Function(DateTime time)? encodeTime}) =>
      json.encode(toEncodable(),
          toEncodable: encodeTime != null
              ? (dynamic object) =>
                  encodeJsonObject(object, encodeTime: encodeTime)
              : encodeJsonObject);

  @override
  Obj object(String key) => _toObject(this[key]);

  @override
  Obj? tryObject(String key) {
    try {
      return object(key);
    } on Exception {
      return null;
    }
  }

  @override
  Arr array(String key) => _toArray(this[key]);

  @override
  Arr? tryArray(String key) {
    try {
      return array(key);
    } on Exception {
      return null;
    }
  }

  @override
  Iterable<Obj> get objects => map.values
      .where((e) => e is Obj || e is Map<String, Object?>)
      .map(_toObject);

  @override
  List<T> objectsToList<T extends Object>(T Function(Obj object) map,
      {int? limit}) {
    var objs = objects;
    if (limit != null) {
      objs = objs.take(limit);
    }
    return objs.map<T>(map).toList(growable: false);
  }

  @override
  Iterable<Arr> get arrays =>
      map.values.where((e) => e is Arr || e is Iterable<Object?>).map(_toArray);

  @override
  List<T> arraysToList<T extends Object>(T Function(Arr array) map,
      {int? limit}) {
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
      return newExposed(e);
    }
    throw ConversionException(target: Obj, data: e);
  }

  Arr _toArray(Object? e) {
    if (e is Arr) {
      return e;
    } else if (e is Iterable<Object?>) {
      return newArrayView(e);
    }
    throw ConversionException(target: Arr, data: e);
  }
}
