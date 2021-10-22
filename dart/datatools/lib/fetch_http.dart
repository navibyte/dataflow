// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

/// Fetch API binding to HTTP and HTTPS resources.
///
/// Usage: import `package:datatools/fetch_http.dart`
library fetch_http;

import 'dart:typed_data';

import 'src/api/content.dart';
import 'src/http/fetch.dart';

export 'fetch_api.dart';
export 'src/http/fetch.dart';

/// Fetch (read fully) content body from a HTTP(S) resource identified by [url].
///
/// Throws an `ApiException` if fetching fails. Also response status codes other
/// than codes for success are thrown as exceptions.
Future<Content> fetch(Uri url, {Map<String, String>? headers}) =>
    headers != null
        ? HttpFetcher.simple().headers(headers).fetch(url)
        : HttpFetcher.simple().fetch(url);

/// Fetch content as a stream from a HTTP(S) resource identified by [url].
///
/// Throws an `ApiException` if fetching fails. Also response status codes other
/// than codes for success are thrown as exceptions.
Future<Content> fetchStream(Uri url, {Map<String, String>? headers}) =>
    headers != null
        ? HttpFetcher.simple().headers(headers).fetchStream(url)
        : HttpFetcher.simple().fetchStream(url);

/// Fetch content body as text from a HTTP(S) resource identified by [url].
///
/// Throws an `ApiException` if fetching fails. Also response status codes other
/// than codes for success are thrown as exceptions.
Future<String> fetchText(Uri url, {Map<String, String>? headers}) =>
    headers != null
        ? HttpFetcher.simple().headers(headers).fetchText(url)
        : HttpFetcher.simple().fetchText(url);

/// Fetch content body as bytes from a HTTP(S) resource identified by [url].
///
/// Throws an `ApiException` if fetching fails. Also response status codes other
/// than codes for success are thrown as exceptions.
Future<Uint8List> fetchBytes(Uri url, {Map<String, String>? headers}) =>
    headers != null
        ? HttpFetcher.simple().headers(headers).fetchBytes(url)
        : HttpFetcher.simple().fetchBytes(url);

/// Fetch content body as JSON data from a HTTP(S) resource identified by [url].
///
/// An optional [reviver] function is applied when decoding json string data.
/// See `JsonCodec` of the `dart:convert` package for more information.
///
/// Throws an `ApiException` if fetching fails. Also response status codes other
/// than codes for success are thrown as exceptions.
Future<dynamic> fetchJson(
  Uri url, {
  Map<String, String>? headers,
  Object? Function(Object? key, Object? value)? reviver,
}) =>
    headers != null
        ? HttpFetcher.simple().headers(headers).fetchJson(url)
        : HttpFetcher.simple().fetchJson(url);
