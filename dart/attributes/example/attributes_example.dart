// Copyright (c) 2020-2022 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

// ignore_for_file: unused_local_variable, avoid_print

import 'package:attributes/attributes.dart';

import 'package:equatable/equatable.dart';

/*
To test run this from command line: 

dart example/attributes_example.dart
*/

void main() {
  // configure Equatable to apply toString() default impls
  EquatableConfig.stringify = true;

  // call sample
  _intro();
}

void _intro() {
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

  // Access an optional data array as a nullable variable.
  final platforms = toolkit.tryArray('platforms');

  // Trying to get an item by index in a data array (here nullable). Returns
  // null if not available, but in this example should return a String.
  final android = platforms?.tryString(1);

  // print sample properties
  print('$name was introduced in $introduced and fainted in ${fainted.year}.');
  print('The website is $web.');
  print('Flutter aims at $fps fps and can be run on $android.');

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

  // Identifiers can be based on String, int or BigInt values, here a String id.
  final dashId = Identifier.fromString('dash-2018');
  if (dashId.isInt) {
    final intId = dashId.asInt();
  } else {
    final stringId = dashId.asString();
  }

  // An entity contains required properties and an optional id.
  final dash = Entity.of(id: dashId, properties: props);
}
