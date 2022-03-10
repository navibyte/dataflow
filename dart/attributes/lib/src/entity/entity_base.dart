// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

import '/src/data.dart';
import '/src/values.dart';

import 'entity.dart';

/// An immutable base implementation of [Entity].
@immutable
class EntityBase extends Entity with EquatableMixin {
  /// A new entity of optional [id] and required [properties].
  ///
  /// The [properties] is required, but allowed to be empty.
  const EntityBase({this.id, required this.properties});

  @override
  final Identifier? id;

  @override
  final DataObject properties;

  // Note: [props] is from [EquatableMixin] and is different from [properties].
  @override
  List<Object?> get props => [id, properties];
}
