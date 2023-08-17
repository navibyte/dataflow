// Copyright (c) 2020-2023 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import '/src/data.dart';
import '/src/values.dart';

import 'entity_base.dart';

/// An interface for an entity with an optional [id] and required [properties]
/// (as a data object).
///
/// As this class is defined with the class modifier `interface`, the class can
/// only be implemented, but not extended. This class also provides factory
/// methods constructing instances of the default implementation provided by
/// [EntityBase].
abstract interface class Entity {
  /// A new entity of an optional [id] and required [properties].
  ///
  /// This is a factory creating an instance of [EntityBase].
  factory Entity.of({Identifier? id, required DataObject properties}) =
      EntityBase;

  /// A new entity of optional [id] and required source [properties].
  ///
  /// This static factory allows [id] to be null or an instance of [Identifier],
  /// `String`, `int` or `BigInt`. In other cases an ArgumentError is thrown.
  ///
  /// The [properties] is used as a source view for an entity. Any changes on
  /// source reflect also on entity properties.
  ///
  /// This is a factory creating an instance of [EntityBase].
  factory Entity.view({Object? id, required Map<String, Object?> properties}) =
      EntityBase.view;

  /// A new entity from JSON Object containg an optional identifier in "id" and
  /// the required properties (JSON Object) in "properties".
  ///
  /// This is a factory creating an instance of [EntityBase].
  factory Entity.fromJson(Map<String, Object?> json) = EntityBase.fromJson;

  /// A new entity from JSON Object containg an optional identifier in "id" and
  /// the required properties (JSON Object) in "properties".
  ///
  /// The underlying map is an object tree as parsed by the standard
  /// `json.decode()` of the `dart:convert` package.
  ///
  /// This is a factory creating an instance of [EntityBase].
  factory Entity.decodeJson(String source) = EntityBase.decodeJson;

  /// An empty entity with empty properties and without id.
  ///
  /// This is a factory creating an instance of [EntityBase].
  factory Entity.empty() = EntityBase.empty;

  /// An optional [id] for this entity.
  Identifier? get id;

  /// The required [properties] for this entity, allowed to be empty.
  DataObject get properties;

  /// Returns data as an encodable object compatible with `json.encode()`.
  ///
  /// The returned JSON Object contains an optional identifier in "id" and
  /// the required properties (JSON Object) in "properties".
  Map<String, Object?> toJson();

  /// Encodes this entity into a JSON string containing a JSON Object.
  ///
  /// The returned JSON Object contains an optional identifier in "id" and
  /// the required properties (JSON Object) in "properties".
  ///
  /// Any `DateTime` objects contained are encoded using [encodeTime] if
  /// provided, or otherwise using `DateTime.toIso8601String()` method.
  String encodeJson({Object Function(DateTime time)? encodeTime});
}
