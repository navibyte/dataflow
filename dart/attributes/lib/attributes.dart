// Copyright (c) 2020-2022 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

/// Decode and encode structured data type-safely from JSON with data utilities.
///
/// Generic data structures for values, identifiers, entities and data objects.
///
/// Supports type-safe and null-safe accessors for value properties.
///
/// `DataObject` can represent data like JSON Objects or properties as a map.
/// `DataArray` can represent data like JSON Arrays or properties as a list.
///
/// Usage: import `package:attributes/attributes.dart`
library attributes;

// Export mini-libraries forming the whole "attributes" library.
export 'collection.dart';
export 'data.dart';
export 'entity.dart';
export 'exceptions.dart';
export 'values.dart';

// Some notes - no need to specifically export following:
// 'data_ext.dart' : not even meant to be exported on the whole "attributes"
