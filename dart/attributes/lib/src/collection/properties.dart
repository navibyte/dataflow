// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import '../values.dart';

import 'counted.dart';
import 'property_list.dart';
import 'property_map.dart';

/// [Properties] is a collection with known size and accessors for typed values.
///
/// May aggregate other collections - property maps or lists - too.
///
/// Normally [K] is either String or int, but could be other types also.
abstract class Properties<K> extends ValueAccessor<K> implements Counted {
  const Properties();

  /// Returns a child property map at [key]
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be represented as [PropertyMap].
  PropertyMap getMap(K key);

  /// Returns a child property map at [key] or null if missing.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// represented as [PropertyMap].
  PropertyMap? tryMap(K key);

  /// Returns a child property list at [key]
  ///
  /// FormatException is thrown if an underlying value is unavailable or
  /// cannot be represented as [PropertyList].
  PropertyList getList(K key);

  /// Returns a child property list at [key] or null if missing.
  ///
  /// `null` is returned if an underlying value is unavailable or cannot be
  /// represented as [PropertyList].
  PropertyList? tryList(K key);
}
