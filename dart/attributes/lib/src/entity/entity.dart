// Copyright (c) 2020-2022 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import '/src/data.dart';
import '/src/values.dart';

import 'entity_base.dart';

/// An entity with an optional [id] and required [properties] as a data object.
abstract class Entity {
  /// Default `const` constructor to allow extending this abstract class.
  const Entity();

  /// A new entity of an optional [id] and required [properties].
  factory Entity.of({Identifier? id, required DataObject properties}) =>
      EntityBase(
        id: id,
        properties: properties,
      );

  /// A new entity of optional [id] and required source [properties].
  ///
  /// This static factory allows [id] to be null or an instance of [Identifier],
  /// `String`, `int` or `BigInt`. In other cases an ArgumentError is thrown.
  ///
  /// The [properties] is used as a source view for an entity. Any changes on
  /// source reflect also on entity properties.
  factory Entity.view({Object? id, required Map<String, Object?> properties}) =>
      EntityBase(
        id: Identifier.idOrNull(id),
        properties: DataObject.view(properties),
      );

  /// An empty entity with empty properties and without id.
  factory Entity.empty() => EntityBase(properties: DataObject.empty());

  /// An optional [id] for this entity.
  Identifier? get id;

  /// The required [properties] for this entity, allowed to be empty.
  DataObject get properties;
}
