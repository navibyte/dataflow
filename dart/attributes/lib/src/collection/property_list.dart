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
import 'property_map.dart';

/// Properties as a list with values accessed by `int` keys.
abstract class PropertyList extends Properties<int> {
  const PropertyList();

  /// Create a [PropertyList] instance backed by [source].
  factory PropertyList.view(List source) = _WrappedPropertyList;

  /// Create a [PropertyList] from [data] containing an encoded JSON Array.
  factory PropertyList.decodeJson(String data) =>
      PropertyList.view(json.decode(data) as List);

  /// Creates an empty [PropertyList].
  factory PropertyList.empty() => const _WrappedPropertyList(<dynamic>[]);
}

/// Private implementation of [PropertyList].
/// The implementation may change in future.
@immutable
class _WrappedPropertyList extends PropertyList
    with ValueAccessorMixin<int>, EquatableMixin {
  const _WrappedPropertyList(this._list);

  final List _list;

  @override
  List<Object?> get props => [_list];

  @override
  int get length => _list.length;

  @override
  bool exists(int key) => key >= 0 && key < length;

  @override
  Object? operator [](int key) => _list[key];

  @override
  PropertyMap getMap(int key) {
    final dynamic props = _list[key];
    if (props is Map<String, dynamic>) {
      return PropertyMap.view(props);
    }
    throw ConversionException(target: PropertyMap, data: props);
  }

  @override
  PropertyMap? tryMap(int key) {
    try {
      return getMap(key);
    } on Exception {
      return null;
    }
  }

  @override
  PropertyList getList(int key) {
    final dynamic props = _list[key];
    if (props is List) {
      return _WrappedPropertyList(props);
    }
    throw ConversionException(target: PropertyList, data: props);
  }

  @override
  PropertyList? tryList(int key) {
    try {
      return getList(key);
    } on Exception {
      return null;
    }
  }
}
