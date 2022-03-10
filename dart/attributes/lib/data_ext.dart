// Copyright (c) 2020-2022 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

/// Data structures to represent data objects and arrays with JSON integration.
///
/// `DataObject` can represent data like JSON Objects or properties as a map.
/// `DataArray` can represent data like JSON Arrays or properties as a list.
///
/// This package is same as the `package:attributes/data.dart` but contains
/// also base implementation classes to help implementing data object and array
/// classes.
///
/// `DataObjectView` implements `DataObject` and is a default implementation for
/// viewing data objects.
///
/// `DataArrayView` implements `DataArray` and is a default implementation for
/// viewing data arrays.
///
/// Both `DataObjectView` and `DataArrayView` can be extended by external code
/// packages as necessary.
///
/// Usage: import `package:attributes/data_ext.dart`
library data_ext;

export 'src/data.dart';

// export also `Identifier` - essential for using data objects and arrays.
export 'src/values.dart' show Identifier;
