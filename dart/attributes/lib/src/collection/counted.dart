// Copyright (c) 2020-2022 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

/// An interface for a collection with countable items.
abstract class Counted {
  /// Default `const` constructor to allow extending this abstract class.
  const Counted();

  /// Returns the number of elements in this collection.
  ///
  /// If not applicable or not known then 0 should be returned.
  int get length;

  /// Returns true if the collection has no elements.
  bool get isEmpty;

  /// Returns true if the collection has at least one element.
  bool get isNotEmpty;
}
