// Copyright (c) 2020-2023 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import '/src/collection.dart';
import '/src/values.dart';

import 'data_array.dart';
import 'data_object.dart';

/// An interface for a data element that is a collection with accessors for
/// typed values.
///
/// May aggregate other collections - data objects and arrays - too as values.
///
/// Normally [K] is either String or int, but could be other types also.
///
/// As this class is defined with the class modifier `interface`, the class can
/// only be implemented, but not extended. This class also do not provide any
/// base implementations, but the known two subtypes are [DataArray] and
/// [DataObject].
abstract interface class DataElement<K> implements ValueAccessor<K>, Counted {
  /// Returns data as an encodable object compatible with `json.encode()`.
  /// 
  /// For data arrays the type of the returned value is `Iterable<Object?>`, and
  /// for data objects `Map<String, Object?>`.
  dynamic toJson();

  /// Encodes this element into a JSON string.
  ///
  /// Any `DateTime` objects contained are encoded using [encodeTime] if
  /// provided, or otherwise using `DateTime.toIso8601String()` method.
  String encodeJson({Object Function(DateTime time)? encodeTime});

  /// Returns a child data object at [key].
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be represented as [DataObject].
  DataObject object(K key);

  /// Returns a child data object at [key] or null if missing.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// represented as [DataObject].
  DataObject? tryObject(K key);

  /// Returns a child data array at [key].
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be represented as [DataArray].
  DataArray array(K key);

  /// Returns a child data array at [key] or null if missing.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// represented as [DataArray].
  DataArray? tryArray(K key);

  /// Returns an iterable for childs that can be represented as [DataObject].
  ///
  /// Other child objects are omitted from an iterable.
  Iterable<DataObject> get objects;

  /// Returns a list of [T] mapped from child data objects using [map] function.
  ///
  /// An optional [limit] when provided limits the number of returned objects.
  ///
  /// The returned list is immutable.
  ///
  /// Other child objects (that cannot be represented as a data objects) are
  /// omitted from an iterable.
  List<T> objectsToList<T extends Object>(
    T Function(DataObject object) map, {
    int? limit,
  });

  /// Returns an iterable for childs that can be represented as [DataArray].
  ///
  /// Other child objects are omitted from an iterable.
  Iterable<DataArray> get arrays;

  /// Returns a list of [T] mapped from child data arrays using [map] function.
  ///
  /// An optional [limit] when provided limits the number of returned objects.
  ///
  /// The returned list is immutable.
  ///
  /// Other child objects (that cannot be represented as a data array) are
  /// omitted from an iterable.
  List<T> arraysToList<T extends Object>(
    T Function(DataArray array) map, {
    int? limit,
  });
}
