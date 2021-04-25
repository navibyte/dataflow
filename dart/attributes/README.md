# Attributes

[![pub package](https://img.shields.io/pub/v/attributes.svg)](https://pub.dev/packages/attributes) [![License](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)](https://opensource.org/licenses/BSD-3-Clause)

**Attributes** is a library package for [Dart](https://dart.dev/) and 
[Flutter](https://flutter.dev/) mobile developers providing generic data 
structures for values, properties, identifiers and entities with type and null 
safe accessors. It also contains utility functions to convert dynamic values to 
typed null-safe primitive values. 

Key features:
* **PropertyMap**: type and null safe access for `Map<String, dynamic>` data
* **PropertyList**: type and null safe access for `List<dynamic>` data
* **Identifier**: an identifier, represented as `String`, `int` or `BigInt`
* **Entity**: a dynamic data entity with optional id and required properties

**This package is at BETA stage, interfaces not fully final yet.** 

## Usage

### Property maps

Dynamic property maps or JSON Objects are often represented as 
`Map<String, dynamic>` objects.

Accessing dynamic data from `Map<String, dynamic>` objects normally means also
a need for many checks or type conversions if you cannot be 100% sure that 
dynamic data is exactly what you are expecting.

Some [solutions](https://flutter.dev/docs/development/data-and-backend/json):
* *Serializing JSON inline*
  * access `Map<String, dynamic>` data directly using the `[]` operator 
* *Serializing JSON inside model classes*
  * to read JSON implement a `fromJson(Map<String, dynamic> json)` constructor
  * or to output JSON implement a `Map<String, dynamic> toJson()` method
* *Serializing JSON using code generation libraries* 
  * many library choices like [json_serializable](https://pub.dev/packages/json_serializable) or [built_value](https://pub.dev/packages/built_value), and others

These solutions are great and working, and they are suggested by the official 
[Dart](https://dart.dev/) and [Flutter](https://flutter.dev/) documentation.

However, for use cases when you just need to access dynamic data from some 
decoded JSON content without code generated classes or even specific model 
classes, then `PropertyMap` helps you on type and null safe access to property 
values.

Imports for examples below:

```dart
import 'package:attributes/attributes.dart';
```

At first, to create a property map, you can simply decode JSON data:

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

  // Decode JSON data as a property map.
  final props = PropertyMap.decodeJson(sample); 
```

`PropertyMap` has two main type of accessors for primitive values like:

```dart
/// Returns a non-null `String` value or throws `FormatException` if data is 
/// unavailable or cannot be converted to a `String`. 
String getString(String key);

/// Returns a nullable `String` value (null when data is unavailable or cannot
/// be converted to a `String`).
String? tryString(String key);
```

Similar accessors are available also for `int`, `BigInt`, `num`, `double`, 
`bool` and `DateTime` values.

Some examples to access primitive values from a property map:

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
  if(users != null) {
    print('The number of users ($users) is now known and it is huge!');
  }

  // Hierarchical data is represented by sub property maps (JSON Objects) or 
  // sub property lists (JSON Arrays). For example property maps can be 
  // accessed by "getMap" (required data) or "tryMap" (optional data) accessors.
  final toolkit = props.getMap('toolkit');

  // Numeric values can be clamped to a range if value validation is needed.
  // Min and max limits are optional parameters when accessing num, int, double,
  // or BigInt.
  final fps = toolkit.getDouble('fps', min: 60.0, max: 120.0);

  // As already described dynamic data like JSON may also contain nulls or an 
  // element for a certain key might not exist at all. Sometimes it's reasonable
  // just to check whether an value exists without trying to access it.
  final lang = props.getMap('language');
  if(lang.exists('nullProperty')) {
    // executes when exists and a value is either null or non-null
  }
  if(lang.existsNull('nullProperty')) {
    // executes when exists and a value is null
  }
  if(lang.existsNonNull('nonNullProperty')) {
    // executes when exists and a value is NOT null
  }

  // This is not a check but accesses a boolean value.
  if(lang.getBool('isNullSafe')) {
    print('Dart has stable sound null-safety!');
  }
```

Other methods available for accessing data from a property map:
```dart
/// Returns the number of properties on a property map.
int get length;

/// Get all property keys.  
Iterable<String> get keys;

/// Returns a value at the key, the result can be of any object or null.
Object? operator [](String key);
```

### Property lists

Dynamic property lists or JSON Arrays are often represented as `List<dynamic>` 
objects, at least when handling decoded JSON data.

Just like for property maps, it's possible to decode a property list from JSON
using `PropertyList.decodeJson` factory constructor.

However, below is a example to access an optional property list from a property
map (`toolkit`) of the previous example:

```dart
  // Access an optional property list as a nullable variable.
  final platforms = toolkit.tryList('platforms');

  // Trying to get an item by index in a property list (here nullable). Returns
  // null if not available, but in this example should return a String. 
  final android = platforms?.tryString(1);
```

Property lists also have similar type-safe accessors for nullable and non-null 
properties as property maps.

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
that has an optional identification by an `Identifier` object and contains 
associated property values in a `PropertyMap` object.

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
functions are also used by `PropertyMap` or `PropertyList` when accessing 
primitive property values with methods described earlier like `getString`, 
`tryString`, `getInt`, etc. 

For example there are converter functions:
* `String valueToString(Object? value);` 
  * Converts `value` to `String` or throws FormatException if cannot convert.
* `int valueToInt(Object? value, {int? min, int? max})` 
  * Converts `value` to `int` or throws FormatException if cannot convert.
  * If provided `min` and `max` are used to clamp the returned value.

Similar functions are available for `BigInt`, `double`, `num`, `bool` and
`DateTime`.

## Installing

The package supports Dart [null-safety](https://dart.dev/null-safety) and 
using it requires at least
[Dart 2.12](https://medium.com/dartlang/announcing-dart-2-12-499a6e689c87)
from the stable channel. Please see the official 
[null-safety migration guide](https://dart.dev/null-safety/migration-guide).

In the `pubspec.yaml` of your project add the dependency:

```yaml
dependencies:
  attributes: ^0.6.0
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
**collection**       | Collections to manage properties in property maps and property lists.
**entity**           | Entity and Identifier data structures for handling dynamic data entities.
**values**           | Value accessors, conversions (dynamic objects to typed values) and helpers.

For example to access a mini library you should use an import like:

```dart
import 'package:attributes/entity.dart';
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



