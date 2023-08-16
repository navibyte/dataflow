// Copyright (c) 2020-2022 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'package:meta/meta.dart';

import '/src/data.dart';
import '/src/values.dart';

import 'entity.dart';

/// An immutable base implementation of [Entity].
///
/// As this class is defined with the class modifier `base`, the class can
/// only be extended, but not implemented. When a subtype should be defined with
/// `implements`, then such a subtype should implement `Entity`.
@immutable
base class EntityBase implements Entity {
  /// A new entity of optional [id] and required [properties].
  ///
  /// The [properties] is required, but allowed to be empty.
  const EntityBase({this.id, required this.properties});

  /// A new entity of optional [id] and required source [properties].
  ///
  /// This static factory allows [id] to be null or an instance of [Identifier],
  /// `String`, `int` or `BigInt`. In other cases an ArgumentError is thrown.
  ///
  /// The [properties] is used as a source view for an entity. Any changes on
  /// source reflect also on entity properties.
  factory EntityBase.view({
    Object? id,
    required Map<String, Object?> properties,
  }) =>
      EntityBase(
        id: Identifier.idOrNull(id),
        properties: DataObject.view(properties),
      );

  /// An empty entity with empty properties and without id.
  factory EntityBase.empty() => EntityBase(properties: DataObject.empty());

  @override
  final Identifier? id;

  @override
  final DataObject properties;

  @override
  bool operator ==(Object other) =>
      other is EntityBase &&
      other.runtimeType == EntityBase &&
      id == other.id &&
      properties == other.properties;

  @override
  int get hashCode => Object.hash(id, properties);
}
