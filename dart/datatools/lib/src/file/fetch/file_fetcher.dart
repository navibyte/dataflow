// Copyright (c) 2020-2023 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'dart:convert';

import 'dart:io' show File;

import 'package:path/path.dart' as p;

import '/src/api/exceptions/client_exception.dart';
import '/src/api/exceptions/origin_exception.dart';
import '/src/api/fetch/fetch_mixin.dart';
import '/src/api/fetch/fetcher.dart';

import 'file_content.dart';

/// A basic file fetcher implementation (using 'dart:io', not working on web).
///
/// This fetcher requires that references used on fetch methods are relative
/// paths.
interface class FileFetcher
    with FetchMixin<FileContent>
    implements Fetcher<FileContent> {
  /// Create a file fetcher with base [path], normally refering to a directory.
  ///
  /// Optionally charset [encoding] or [contentType] can be set to specify those
  /// attributes of files accessed by this client.
  factory FileFetcher.basePath(
    String path, {
    Encoding encoding = utf8,
    String? contentType,
  }) =>
      FileFetcher._(path, encoding, contentType);

  FileFetcher._(this._basePath, this._encoding, this._contentType);

  final String _basePath;
  final Encoding _encoding;
  final String? _contentType;

  /// Ignore given [headers] on this version of the [FileFetcher].
  ///
  /// Returns `this` without mutations.
  @override
  FileFetcher headers(Map<String, String> headers) => this;

  @override
  Future<FileContent> fetch(Uri reference) async {
    final file = await _fileFromUri(reference);
    try {
      return FileContent(
        reference,
        file,
        contentType: _contentType,
        encoding: _encoding,
        contentLength: await file.length(),
      );
    } on Exception catch (e) {
      throw ClientException.failed(reference, e);
    }
  }

  @override
  Future<FileContent> fetchStream(Uri reference) => fetch(reference);

  Future<File> _fileFromUri(
    Uri reference, [
    bool expectFileExists = true,
  ]) async {
    if (reference.hasAuthority || reference.isAbsolute) {
      throw ClientException.notRelative(reference);
    }
    final file = File(p.join(_basePath, reference.path));
    if (expectFileExists) {
      if (!file.existsSync()) {
        throw OriginException.of(
          'File not existing',
          reference: reference,
          failure: OriginFailure.notFound,
        );
      }
    }
    return file;
  }
}
