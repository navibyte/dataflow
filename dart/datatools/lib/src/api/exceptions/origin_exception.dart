// Copyright (c) 2020-2023 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'api_exception.dart';

/// Common failure types related to [OriginException].
///
/// Note: this is not protocol specific failure type, so this enumeration does
/// not list all those familiar status codes of HTTP protocol.
enum OriginFailure {
  /// An origin failure is `undefined` or other than those specified.
  undefined,

  /// An origin failure is `notModified` (like 304 for HTTP).
  notModified,

  /// An origin failure is `badRequest` (like 400 for HTTP).
  badRequest,

  /// An origin failure is `unauthrorized` (like 401 for HTTP).
  unauthorized,

  /// An origin failure is `forbidden` (like 403 for HTTP).
  forbidden,

  /// An origin failure is `notFound` (like 404 for HTTP).
  notFound,

  /// An origin failure is `notAcceptable` (like 406 for HTTP).
  notAcceptable,
}

/// An exception containing a failure message as a response from an API origin.
abstract base class OriginException extends ApiException {
  /// A default constructor of [message] and an optional [reference].
  const OriginException(super.message, {super.reference});

  /// Create an exception of [message], [failure] and [statusCode].
  ///
  /// Optionally also [reference] and [reasonPhrase] can be given.
  ///
  /// The default for [failure] is `undefined` and for [statusCode] is `0`.
  factory OriginException.of(
    String message, {
    Uri? reference,
    OriginFailure failure,
    int statusCode,
    String? reasonPhrase,
  }) = _OriginExceptionBase;

  /// Common failure type. By default `undefined` if not set.
  OriginFailure get failure => OriginFailure.undefined;

  /// Protocol (like HTTP) specific status code. By default 0 if not set.
  int get statusCode => 0;

  /// Protocol (like HTTP) specific reason phrase. By default nul if not set.
  String? get reasonPhrase => null;

  /// True if [failure] is `notModified`.
  bool get isNotModified => failure == OriginFailure.notModified;

  /// True if [failure] is `badRequest`.
  bool get isBadRequest => failure == OriginFailure.badRequest;

  /// True if [failure] is `unauthorized`.
  bool get isUnauthorized => failure == OriginFailure.unauthorized;

  /// True if [failure] is `forbidden`.
  bool get isForbidden => failure == OriginFailure.forbidden;

  /// True if [failure] is `notFound`.
  bool get isNotFound => failure == OriginFailure.notFound;

  /// True if [failure] is `notAcceptable`.
  bool get isNotAcceptable => failure == OriginFailure.notAcceptable;
}

base class _OriginExceptionBase extends OriginException {
  const _OriginExceptionBase(
    super.message, {
    super.reference,
    this.failure = OriginFailure.undefined,
    this.statusCode = 0,
    this.reasonPhrase,
  });

  @override
  final OriginFailure failure;

  @override
  final int statusCode;

  @override
  final String? reasonPhrase;
}
