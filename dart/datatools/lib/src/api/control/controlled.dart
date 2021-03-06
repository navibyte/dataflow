// Copyright (c) 2020-2022 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

/// An interface to set control data to a client (ie. HTTP client or fetcher).
abstract class Controlled<C> {
  /// Default `const` constructor to allow extending this abstract class.
  const Controlled();

  /// Returns a new controlled object of [C] with given [headers] applied to it.
  C headers(Map<String, String> headers);
}
