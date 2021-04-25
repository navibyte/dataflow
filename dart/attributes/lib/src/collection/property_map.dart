// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'dart:convert';

import 'package:meta/meta.dart';

import 'package:equatable/equatable.dart';

import '../values.dart';

import 'properties.dart';
import 'property_list.dart';

/// Properties as a map with values accessed by `String` keys.
abstract class PropertyMap extends Properties<String> {
  const PropertyMap();

  /// Create a [PropertyMap] instance backed by [source].
  factory PropertyMap.view(Map<String, dynamic> source) = _WrappedPropertyMap;

  /// Create a [PropertyMap] from [data] containing an encoded JSON Object.
  factory PropertyMap.decodeJson(String data) =>
      PropertyMap.view(json.decode(data) as Map<String, dynamic>);

  /// Creates an empty [PropertyMap].
  factory PropertyMap.empty() => const _WrappedPropertyMap(<String, dynamic>{});

  /// Returns map [keys].
  Iterable<String> get keys;

  /// Returns properties or key-value pairs as a [map], allowed to be empty.
  ///
  /// This is deprecated, may be removed in future.
  @Deprecated('Use type-safe accessors instead.')
  Map<String, dynamic> get map;
}

/// Private implementation of [PropertyMap].
/// The implementation may change in future.
@immutable
class _WrappedPropertyMap extends PropertyMap
    with ValueAccessorMixin<String>, EquatableMixin {
  const _WrappedPropertyMap(this.map);

  @override
  final Map<String, dynamic> map;

  @override
  List<Object?> get props => [map];

  @override
  int get length => map.length;

  @override
  bool exists(String key) => keys.contains(key);

  @override
  Iterable<String> get keys => map.keys;

  @override
  Object? operator [](String key) => map[key];

  @override
  PropertyMap getMap(String key) {
    final dynamic props = map[key];
    if (props is Map<String, dynamic>) {
      return PropertyMap.view(props);
    }
    throw ConversionException(target: PropertyMap, data: props);
  }

  @override
  PropertyMap? tryMap(String key) {
    try {
      return getMap(key);
    } on Exception {
      return null;
    }
  }

  @override
  PropertyList getList(String key) {
    final dynamic props = map[key];
    if (props is List) {
      return PropertyList.view(props);
    }
    throw ConversionException(target: PropertyList, data: props);
  }

  @override
  PropertyList? tryList(String key) {
    try {
      return getList(key);
    } on Exception {
      return null;
    }
  }
}
