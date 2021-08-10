// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import '../address.dart';

import 'body.dart';
import 'head.dart';

/// Content represents a data entity.
abstract class Content extends Head implements Anchor, Body {
  const Content();

  /// Returns a future for a single-subscription stream with content data.
  ///
  /// This is deprecated, may be removed in future.
  @Deprecated('Use byteStream accessor instead.')
  Future<Stream<List<int>>> get stream;
}
