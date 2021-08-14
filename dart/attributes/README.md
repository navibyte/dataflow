<h2 align="center">Decode and encode structured data type-safely</h2>

[![pub package](https://img.shields.io/pub/v/attributes.svg)](https://pub.dev/packages/attributes) [![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

Utilities to handle structured data like values, identifiers, entities, data 
objects and data arrays. With JSON serialization support.

Key features:
* Type-safe and null-safe accessors for data and value properties
* JSON decoding and encoding for data objects and arrays
* Utility functions to convert dynamic values to null-safe primitive value types
* **DataObject**: represent data like JSON Objects or properties as a map
* **DataArray**: represent data like JSON Arrays or properties as a list
* **Identifier**: an identifier, represented as `String`, `int` or `BigInt`
* **Entity**: a dynamic data entity with optional id and required properties

**This package is at BETA stage, interfaces not fully final yet.** 

## Introduction

Let's first consider some alternatives for [Dart](https://dart.dev/) and 
[Flutter](https://flutter.dev/) developers to parse JSON and map data fields to 
a domain model.

To do this we need a sample domain model:

```dart
class Address {
  final String street;
  final String city;

  const Address({required this.street, required this.city});
}

class Person {
  final String name;
  final int age;
  final double? length;
  final Address address;
  final DateTime updatedUTC;

  const Person(
      {required this.name,
      required this.age,
      this.length,
      required this.address,
      required this.updatedUTC});
}
```

### Serializing JSON traditionally without "attributes"

There are multiple offically supported 
[solutions](https://flutter.dev/docs/development/data-and-backend/json)
to handle JSON like:
* *Serializing JSON inline*
  * access `Map<String, dynamic>` data directly using the `[]` operator 
* *Serializing JSON inside model classes*
  * to read JSON implement a `fromJson(Map<String, dynamic> json)` constructor
  * to output JSON implement a `Map<String, dynamic> toJson()` method
* *Serializing JSON using code generation libraries* 
  * many library choices like [json_serializable](https://pub.dev/packages/json_serializable) or [built_value](https://pub.dev/packages/built_value), and others

Of these solutions we review a basic tradional way of implementing a 
`fromJson` factories and a `toJson` methods. 

A sample with a simple domain model and JSON serialization support:

```dart
class Address {
  // ... showing only decoding part ...
  factory Address.fromJson(Map<String, dynamic> json) => Address(
        street: json['street'] as String,
        city: json['city'] as String,
      );
}

class Person {
  // ... showing only decoding part ...
  factory Person.fromJson(Map<String, dynamic> json) => Person(
      name: json['name'] as String,
      age: json['age'] as int,
      length: json['length'] as double?,
      address: Address.fromJson(json['address'] as Map<String, dynamic>),
      updatedUTC: DateTime.parse(json['updated'] as String).toUtc());
}
```

As you can see this approach may require a lot of type casts (at least when you
have disabled `implicit-casts` and `implicit-dynamic` on your 
analysis-options.yaml as you 
[maybe should](https://dash-overflow.net/articles/getting_started/)), null 
checks, value conversions and validations that can be error-prone. Also this 
solution couples your domain model to JSON encoding (be it a good or bad 
feature).

Such traditional domain models can be decoded and encoded as a common practise:

```dart
import 'dart:convert';

// Decode JSON and create a domain model object.
final person = Person.fromJson(
      json.decode(someJsonData) as Map<String, dynamic>);

// A domain model object encoded back to JSON.
print(json.encode(person.toJson()));
```

### Type-safe and null-safe data objects to help

The **attributes** package provides type-safe and null-safe accessors to consume
structured data like JSON. 

The following sample replaces `Map<String, dynamic>` types on serialization code
with `DataObject` classes. This allows data fields accessed more type safely:
* required fields read like `data.getString('street')` returning non-null values
* optional fields read like `data.tryDouble('length')` returning nullable values

Sample code shows differences best between this solution and a traditional way:

```dart
import 'package:attributes/data.dart';

class Address {
  // ... showing only decoding part ...
  factory Address.fromData(DataObject data) => Address(
        street: data.getString('street'),
        city: data.getString('city'),
      );
}

class Person {
  // ... showing only decoding part ...
  factory Person.fromData(DataObject data) => Person(
      name: data.getString('name'),
      age: data.getInt('age'),
      length: data.tryDouble('length'),
      address: Address.fromData(data.object('address')),
      updatedUTC: data.getTimeUTC('updated'));
}
```

Such type-safe domain models can be decoded and encoded as:

```dart
// Decode JSON and create a domain model object.
final person = Person.fromData(DataObject.decodeJson(someJsonData));

// A domain model object encoded back to JSON.
print(person.toData().encodeJson());
```

Please see the [full sample code](example/data_object_example.dart) describing
both decoding and encoding parts, and data arrays along with data object 
introduced above.

When comparing to the traditional way, we still need almost as much lines to be
coded but reading data is much more safe when considering types and
nullability. 

This code is a bit cleaner too as a bonus!

The `DataObject` interface does not depend on JSON encoding, even if this
sample populated an generic data object using the `DataObject.decodeJson()` 
factory and a JSON data source, and then it was accessed by domain classes in 
`Address.fromData(DataObject data)` and `Person.fromData(DataObject data)` 
factories. Anyway it's possible to extend `DataObject` class to support 
also other encodings than JSON. However, such support is out of scope of this
library.

## Usage

### Data objects

As already introduced dynamic property maps or JSON Objects are often 
represented as `Map<String, dynamic>` objects. Accessing dynamic data from such
data structures a need for many checks or type conversions if you cannot be 100%
sure that dynamic data is exactly what you are expecting.

However, for use cases when you just need to access dynamic data from some 
decoded JSON content without code generated classes or even specific model 
classes, then `DataObject` helps you on type and null safe access to property 
values.

Imports for examples below:

```dart
import 'package:attributes/attributes.dart';
```

At first, to create a data object, you can simply decode JSON data:

```dart
  // sample JSON data
  const sample = '''
    {
      "name": "Dash",
      "type": "mascot",
      "introduced": 2018,
      "fainted": "2021-03-03",
      "language": {
        "name": "Dart",
        "isNullSafe": true,
        "nullProperty": null,
        "nonNullProperty": "nonNull"
      },
      "toolkit": {
        "name": "Flutter",
        "fps": 60.0,
        "platforms": [ "iOS", "Android", "Windows", "macOS", "Linux", "Web"]
      }
    }
  ''';

  // Decode JSON data as a data object.
  final props = DataObject.decodeJson(sample);
```

`DataObject` has two main type of accessors for primitive values like:

```dart
/// Returns a non-null `String` value or throws `FormatException` if data is 
/// unavailable or cannot be converted to a `String`. 
String getString(String key);

/// Returns a nullable `String` value (null when data is unavailable or cannot
/// be converted to a `String`).
String? tryString(String key);
```

Similar accessors are available also for `int`, `BigInt`, `num`, `double`, 
`bool`, `DateTime` and `Identifier` values.

Some examples to access primitive values from a data object:

```dart
  // Access required null-safe properties using type-safe getXXX accessors.
  // These calls throw if a property is missing or does not convert to a type.
  final name = props.getString('name');
  final introduced = props.getInt('introduced');
  final fainted = props.getTimeUTC('fainted');

  // Access optional nullable properties using type-safe tryXXX accessors.
  // These calls never throw but return null if a property is missing or does
  // not convert to a type. An optional default value cab be given after
  // null-aware operator `??`.
  final web = props.tryString('web') ?? 'https://flutter.dev/dash';

  /// It's easy to check nullable values from accessors of optional properties.
  final users = props.tryBigInt('knownUsers');
  if (users != null) {
    print('The number of users ($users) is now known and it is huge!');
  } else {
    print('Data for known users not yet collected.');
  }

  // Hierarchical data is represented by sub data objects (JSON Objects) or
  // sub data arrays (JSON Arrays). For example data objects can be
  // accessed by "object" (required data) or "tryObject" (optional) accessors.
  final toolkit = props.object('toolkit');

  // Numeric values can be clamped to a range if value validation is needed.
  // Min and max limits are optional parameters when accessing num, int, double,
  // or BigInt.
  final fps = toolkit.getDouble('fps', min: 60.0, max: 120.0);

  // As already described dynamic data like JSON may also contain nulls or an
  // element for a certain key might not exist at all. Sometimes it's reasonable
  // just to check whether an value exists without trying to access it.
  final lang = props.object('language');
  if (lang.exists('nullProperty')) {
    // executes when exists and a value is either null or non-null
  }
  if (lang.existsNull('nullProperty')) {
    // executes when exists and a value is null
  }
  if (lang.existsNonNull('nonNullProperty')) {
    // executes when exists and a value is NOT null
  }

  // This is not a check but accesses a required boolean value.
  if (lang.getBool('isNullSafe')) {
    print('Dart is null-safe!');
  }
```

### Data arrays

Dynamic property lists or JSON Arrays are often represented as `List<dynamic>` 
objects, at least when handling decoded JSON data.

Just like for data objects, it's possible to decode a data array from JSON
using `DataArray.decodeJson` factory constructor.

However, below is a example to access an optional data object from a data object
(`toolkit`) of the previous example:

```dart
  // Access an optional data array as a nullable variable.
  final platforms = toolkit.tryArray('platforms');

  // Trying to get an item by index in a data array (here nullable). Returns
  // null if not available, but in this example should return a String.
  final android = platforms?.tryString(1);
```

Data arrays also have similar type-safe accessors for nullable and non-null 
properties as data objects.

### Identifiers

Identifiers could be represented as String or integer values. For dynamic 
data it's possible that primitive data types for identifiers are not known
by code consuming such data.

The `Identifier` class allows creating an instance from a primitive value that 
could be either String or integer. Then a client can dynamically check a type, 
or convert an identifier to `String`, `int` or `BigInt` representation.

This is demonstrated below:

```dart
  // Identifiers can be based on String, int or BigInt values, here a String id.
  final dashId = Identifier.fromString('dash-2018');
  if(dashId.isInt) {
    final intId = dashId.asInt();
  } else {
    final stringId = dashId.asString();
  }
```

Identifier type can be checked using `isString`, `isInteger`, `isInt` and
`isBigInt` properties. When expecting a specific type, `asString`, `asInteger`, 
`asInt` and `asBigInt` accessors are used. If not sure about a type, but you 
want to avoid format exceptions, then `tryString`, `tryInteger`, `tryInt` and
`tryBigInt` returns a value or a null if not available as a requested type.

### Entities

In the context of this package, an `Entity` represents a structured data entity
that has an optional id as an `Identifier` object and contains associated 
property values in a `DataObject` instance.

An example how to create an entity (with `dashId` and `props` refering to 
variables from previous examples):

```dart
  // An entity contains required properties and an optional id.
  final dash = Entity.of(
    id: dashId,
    properties: props);
```

The [geocore](https://pub.dev/packages/geocore) package has a `Feature` class
that extends `Entity`, and has also geospatial `geometry` and `bounds` as 
fields along with `id` and `properties` fields. That is a *feature* is a
geospatial *entity* object.

### Value conversions

Conversions from JSON elements or other dynamic data structures can be converted
to primitive values using utility functions provided by the package. These
functions are also used by `DataObject` or `DataArray` when accessing 
primitive property values with methods described earlier like `getString`, 
`tryString`, `getInt`, etc. 

For example there are converter functions:
* `String toStringValue(Object? data);` 
  * Converts `data` to `String` or throws FormatException if cannot convert.
* `int toIntValue(Object? data, {int? min, int? max})` 
  * Converts `data` to `int` or throws FormatException if cannot convert.
  * If provided `min` and `max` are used to clamp the returned value.

Similar functions are available for `BigInt`, `double`, `num`, `bool`,
`DateTime` and `Identifier`.

These conversion functions try their best to convert to a desired type, not just
type casting. For example the implementation for `toDoubleValue` explains this:

```dart
double toDoubleValue(Object? data, {double? min, double? max}) {
  if (data == null) throw NullValueException();
  double result;
  if (data is num) {
    result = data.toDouble();
  } else if (data is BigInt) {
    result = data.toDouble();
  } else if (data is String) {
    result = double.parse(data);
  } else if (data is bool) {
    result = data ? 1.0 : 0.0;
  } else {
    throw ConversionException(target: double, data: data);
  }
  if (min != null && result < min) {
    result = min;
  }
  if (max != null && result > max) {
    result = max;
  }
  return result;
}
```

## Installing

The package supports Dart [null-safety](https://dart.dev/null-safety) and 
using it requires at least
[Dart 2.12](https://medium.com/dartlang/announcing-dart-2-12-499a6e689c87)
from the stable channel. Please see the official 
[null-safety migration guide](https://dart.dev/null-safety/migration-guide).

In the `pubspec.yaml` of your project add the dependency:

```yaml
dependencies:
  attributes: ^0.7.3
```

All dependencies used by `attributes` are also ready for 
[null-safety](https://dart.dev/null-safety)!

## Package

This is a [Dart](https://dart.dev/) code package named `attributes` under the 
[dataflow](https://github.com/navibyte/dataflow) repository. 

The package is associated with (but not depending on) the
[geocore](https://pub.dev/packages/geocore) package. The `attributes` package 
contains non-geospatial data structures that are extended and utilized by the 
`geocore` package to provide geospatial data structures and utilities. 

## Libraries

The package contains following mini-libraries:

Library              | Description 
-------------------- | -----------
**collection**       | Base classes for collection implementations. Currently only the `Counted` interface.
**data**             | Data objects and arrays representing generic data and with JSON integration.
**data_ext**         | Same as `data` but contains also base implementation classes.
**entity**           | Data entities consisting of a data object (properties) and an identifier.
**exceptions**       | Exceptions specializing the standard `FormatException`.
**values**           | Value accessors, conversions (dynamic objects to typed values) and helpers.

For example to access a mini library you should use an import like:

```dart
import 'package:attributes/data.dart';
```

To use all libraries of the package:

```dart
import 'package:attributes/attributes.dart';
```

## Authors

This project is authored by [Navibyte](https://navibyte.com).

More information and other links are available at the
[dataflow](https://github.com/navibyte/dataflow) repository from GitHub. 

## License

This project is licensed under the "BSD-3-Clause"-style license.

Please see the 
[LICENSE](https://github.com/navibyte/dataflow/blob/main/LICENSE).
