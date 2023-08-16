// Copyright (c) 2020-2023 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'package:equatable/equatable.dart';

import 'package:meta/meta.dart';

/// Represents a resource link.
///
/// Compatible with: http://schemas.opengis.net/ogcapi/features/part1/1.0/openapi/schemas/link.yaml
@immutable
base class Link with EquatableMixin {
  /// Link with [href]. Optional: [rel], [type], [hreflang], [title], [length].
  const Link({
    required this.href,
    this.rel,
    this.type,
    this.hreflang,
    this.title,
    this.length,
  });

  /// A link from decoded JSON objects.
  Link.fromJson(Map<String, Object?> json)
      // ignore: cast_nullable_to_non_nullable
      : href = json['href'] as String,
        rel = json['rel'] as String?,
        type = json['type'] as String?,
        hreflang = json['hreflang'] as String?,
        title = json['title'] as String?,
        length = json['length'] as int?;

  /// The [href] part of a link.
  final String href;

  /// An optional [rel] part of a link.
  final String? rel;

  /// An optional [type] part of a link.
  final String? type;

  /// An optional [hreflang] part of a link.
  final String? hreflang;

  /// An optional [title] part of a link.
  final String? title;

  /// An optional [length] part of a link.
  final int? length;

  @override
  List<Object?> get props => [href, rel, type, hreflang, title, length];
}
