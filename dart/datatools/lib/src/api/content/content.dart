// Copyright (c) 2020-2023 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import '/src/api/address/anchor.dart';

import 'body.dart';
import 'head.dart';

/// Content represents a data entity.
abstract class Content extends Head implements Anchor, Body {
  /// Default `const` constructor to allow extending this abstract class.
  const Content();
}
