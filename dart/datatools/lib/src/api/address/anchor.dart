// Copyright (c) 2020-2023 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

/// An interface for a resource anchor.
abstract interface class Anchor {
  /// The URI [reference] to a resource this anchor is referring.
  Uri get reference;
}
