// Copyright (c) 2020-2022 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

/// An anchor for a resource.
abstract class Anchor {
  /// Default `const` constructor to allow extending this abstract class.
  const Anchor();

  /// The URI [reference] to a resource this anchor is referring.
  Uri get reference;
}
