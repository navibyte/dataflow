// Copyright (c) 2020-2023 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'dart:convert';
import 'dart:typed_data';

String b2s(Uint8List data) => utf8.decode(data);

String bd2s(ByteData data) => utf8.decode(Uint8List.sublistView(data));
