// Copyright (c) 2020-2023 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'dart:typed_data';

import '/src/api/content.dart';

import 'fetch_api.dart';

/// A mixin for [FetchApi] with partial implemention.
mixin FetchMixin<C extends Content> implements FetchApi<C> {
  @override
  Future<String> fetchText(Uri reference) async =>
      (await fetch(reference)).text;

  @override
  Future<Uint8List> fetchBytes(Uri reference) async =>
      (await fetch(reference)).bytes;

  @override
  Future<dynamic> fetchJson(
    Uri reference, {
    Object? Function(Object? key, Object? value)? reviver,
  }) async =>
      (await fetch(reference)).decodeJson(reviver: reviver);
}
