// Copyright (c) 2020-2022 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import '/src/api/address.dart';

import 'body.dart';
import 'head.dart';

/// Content represents a data entity.
abstract class Content extends Head implements Anchor, Body {
  /// Default `const` constructor to allow extending this abstract class.
  const Content();

  /// Returns a future for a single-subscription stream with content data.
  ///
  /// This is deprecated, may be removed in future.
  @Deprecated('Use byteStream accessor instead.')
  Future<Stream<List<int>>> get stream;
}
