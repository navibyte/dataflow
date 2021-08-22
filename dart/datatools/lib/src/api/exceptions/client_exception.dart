// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

import 'api_exception.dart';

/// An exception occurred when accessing an API and caused by client-side code.
class ClientException extends ApiException {
  /// Create an exception of [message], and optional [reference] and [cause].
  const ClientException(String message, {Uri? reference, this.cause})
      : super(message, reference: reference);

  /// An optional wrapped [cause] exception.
  final dynamic cause;

  /// Create an exception describing that [reference] is not a relative one.
  factory ClientException.notRelative(Uri reference) =>
      ClientException('$reference is not relative reference',
          reference: reference);

  /// Create an exception describing that [reference] is not allowd.
  factory ClientException.uriNotAllowed(Uri reference) =>
      ClientException('$reference is not allowed', reference: reference);

  /// Create an exception describing [type] is not supported for [reference].
  factory ClientException.typeNotSupported(Uri reference, Type type) =>
      ClientException('Requested $type for $reference is not supported',
          reference: reference);

  /// Create an exception describing data of [dataType] is not supported.
  ///
  /// An exception related to [reference].
  factory ClientException.dataNotSupported(Uri reference, Type dataType) =>
      ClientException('Data of $dataType for $reference is not supported',
          reference: reference);

  /// Create an exception describing data of [dataType] is not supported.
  ///
  /// An exception related to [reference] and [type] for expected for a type.
  factory ClientException.dataForTypeNotSupported(
          Uri reference, Type type, Type dataType) =>
      ClientException(
          'Data of $dataType (requested $type) for $reference is not supported',
          reference: reference);

  /// Create an exception telling that calling [reference] failed with [cause].
  factory ClientException.failed(Uri reference, dynamic cause) =>
      ClientException('Calling $reference failed: $cause',
          cause: cause, reference: reference);

  /// Create an exception telling that a opening stream failed with [cause].
  factory ClientException.openingStreamFailed(dynamic cause) =>
      ClientException('Opening stream failed: $cause', cause: cause);

  /// Create an exception telling that reading text failed with [cause].
  factory ClientException.readingTextFailed(dynamic cause) =>
      ClientException('Reading text failed: $cause', cause: cause);

  /// Create an exception telling that reading bytes failed with [cause].
  factory ClientException.readingBytesFailed(dynamic cause) =>
      ClientException('Reading bytes failed: $cause', cause: cause);

  /// Create an exception telling that decoding JSON data failed with [cause].
  factory ClientException.decodingJsonFailed(dynamic cause) =>
      ClientException('Decoding json failed: $cause', cause: cause);
}
