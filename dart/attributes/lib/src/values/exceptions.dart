// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

/// A [FormatException] notifying about an undefined or missing value.
class UndefinedValueException extends FormatException {
  const UndefinedValueException({String? message})
      : super(message ?? 'Value is undefined or missing.');
}

/// A [FormatException] notifying about a null value.
class NullValueException extends FormatException {
  const NullValueException({String? message})
      : super(message ?? 'Value is null.');
}

/// A [FormatException] notifying about an invalid value
class InvalidValueException extends FormatException {
  const InvalidValueException(Object? data, {String? message})
      : super(message ?? 'Invalid value.', data);
}

/// A [FormatException] notifying about an unsupported conversion.
class ConversionException extends FormatException {
  const ConversionException(
      {Object? data, required Type target, String? message})
      : super(
            message ??
                'Unsupported conversion to $target or invalid source data.',
            data);
}
