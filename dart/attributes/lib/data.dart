// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

/// Data objects and arrays representing generic data and with JSON integration.
///
/// `DataObject` can represent data like JSON Objects or properties as a map.
/// `DataArray` can represent data like JSON Arrays or properties as a list.
///
/// It's possible to implement these interfaces to support also other data
/// encodings than just JSON. However this package provides only JSON
/// integration.
///
/// Usage: import `package:attributes/data.dart`
library data;

export 'src/data.dart' hide DataObjectView, DataArrayView;

// export also `Identifier` - essential for using data objects and arrays.
export 'src/values.dart' show Identifier;

