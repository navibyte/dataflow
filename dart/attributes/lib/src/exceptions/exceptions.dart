// Copyright (c) 2020-2022 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

/// A [FormatException] notifying about an undefined or missing value.
class UndefinedValueException extends FormatException {
  /// Create an exception of an optional [message].
  const UndefinedValueException({String? message})
      : super(message ?? 'Value is undefined or missing.');
}

/// A [FormatException] notifying about a null value.
class NullValueException extends FormatException {
  /// Create an exception of an optional [message].
  const NullValueException({String? message})
      : super(message ?? 'Value is null.');
}

/// A [FormatException] notifying about an invalid value
class InvalidValueException extends FormatException {
  /// Create an exception of a reference to [data] and an optional [message].
  const InvalidValueException(Object? data, {String? message})
      : super(message ?? 'Invalid value.', data);
}

/// A [FormatException] notifying about an unsupported conversion.
class ConversionException extends FormatException {
  /// Create an exception of a reference to [data] and a [target] type.
  ///
  /// Optionally [message] can be given too.
  const ConversionException({
    Object? data,
    required Type target,
    String? message,
  }) : super(
          message ??
              'Unsupported conversion to $target or invalid source data.',
          data,
        );
}
