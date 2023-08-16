// Copyright (c) 2020-2023 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import '/src/api/content/content.dart';
import '/src/api/control/controlled.dart';

import 'fetch_api.dart';

/// A interface supporting [FetchApi] for fetching and [Controlled] for control
/// data.
abstract interface class Fetcher<C extends Content>
    implements FetchApi<C>, Controlled<Fetcher<C>> {}
