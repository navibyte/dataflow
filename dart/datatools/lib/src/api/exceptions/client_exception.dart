// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

// ignore_for_file: sort_constructors_first

import 'api_exception.dart';

/// An exception occurred when accessing an API and caused by client-side code.
class ClientException extends ApiException {
  const ClientException(String message, {Uri? uri, this.cause})
      : super(message, reference: uri);

  /// An optional wrapped [cause] exception.
  final dynamic cause;

  factory ClientException.notRelative(Uri uri) =>
      ClientException('$uri is not relative reference', uri: uri);

  factory ClientException.uriNotAllowed(Uri uri) =>
      ClientException('$uri is not allowed', uri: uri);

  factory ClientException.typeNotSupported(Uri uri, Type type) =>
      ClientException('Requested $type for $uri is not supported', uri: uri);

  factory ClientException.dataNotSupported(Uri uri, Type dataType) =>
      ClientException('Data of $dataType for $uri is not supported', uri: uri);

  factory ClientException.dataForTypeNotSupported(
          Uri uri, Type type, Type dataType) =>
      ClientException(
          'Data of $dataType (requested $type) for $uri is not supported',
          uri: uri);

  factory ClientException.failed(Uri uri, dynamic cause) =>
      ClientException('Calling $uri failed: $cause', cause: cause, uri: uri);

  factory ClientException.openingStreamFailed(dynamic cause) =>
      ClientException('Opening stream failed: $cause', cause: cause);

  factory ClientException.readingTextFailed(dynamic cause) =>
      ClientException('Reading text failed: $cause', cause: cause);

  factory ClientException.readingBytesFailed(dynamic cause) =>
      ClientException('Reading bytes failed: $cause', cause: cause);

  factory ClientException.decodingJsonFailed(dynamic cause) =>
      ClientException('Decoding json failed: $cause', cause: cause);
}
