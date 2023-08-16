// Copyright (c) 2020-2023 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

/// Generic API abstractions (address, content, control data, exceptions).
///
/// Usage: import `package:datatools/base_api.dart`
library base_api;

export 'src/api/address/anchor.dart';
export 'src/api/address/uri_resolver.dart';
export 'src/api/content/body.dart';
export 'src/api/content/content.dart';
export 'src/api/content/head.dart';
export 'src/api/control/controlled.dart';
export 'src/api/exceptions/api_exception.dart';
export 'src/api/exceptions/client_exception.dart';
export 'src/api/exceptions/origin_exception.dart';
