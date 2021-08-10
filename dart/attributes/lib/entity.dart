// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

/// Data entities consisting of a data object (properties) and an identifier.
///
/// Usage: import `package:attributes/entity.dart`
library entity;

// export also `Identifier` and `DataObject` - essential classes for entities.
export 'src/data.dart' show DataObject;
export 'src/values.dart' show Identifier;

// the actual code for `package:attributes/entity.dart`
export 'src/entity.dart';
