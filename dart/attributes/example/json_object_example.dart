// Copyright (c) 2020-2022 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

// ignore_for_file: avoid_print

/*
Same as "data_object_example.dart" but:
- NOT using the 'package:attributes/data.dart' package
- so this sample uses only the Dart standard library 
- also note that analysis_options.yaml has following recommend settings: 
   implicit-casts: false
  implicit-dynamic: false

To test run this from command line: 

dart example/json_object_example.dart
*/

import 'dart:convert';

void main() {
  _decodeSampleData();
}

/// [Address] model with [street] and [city] fields.
///
/// Sample source data as a JSON Object:
/// `{ "street": "Main street", "city": "Anytown" }`
class Address {
  final String street;
  final String city;

  const Address({required this.street, required this.city});

  static Address fromJson(Map<String, dynamic> json) => Address(
        street: json['street'] as String,
        city: json['city'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'street': street,
        'city': city,
      };
}

/// [Person] with [name], [age], an optional [length] and aggregated [address].
///
/// Sample source data as a JSON Object:
/// ```json
///   {
///     "name": "John Doe",
///     "age": 52,
///     "length": 1.75,
///     "address": { "street": "Main street", "city": "Anytown" },
///     "updated": "2021-08-09 09:00Z"
///   }
/// ```
class Person {
  final String name;
  final int age;
  final double? length;
  final Address address;
  final DateTime updatedUTC;

  const Person({
    required this.name,
    required this.age,
    this.length,
    required this.address,
    required this.updatedUTC,
  });

  static Person fromJson(Map<String, dynamic> json) => Person(
        name: json['name'] as String,
        age: json['age'] as int,
        length: json['length'] as double?,
        address: Address.fromJson(json['address'] as Map<String, dynamic>),
        updatedUTC: DateTime.parse(json['updated'] as String).toUtc(),
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': name,
        'age': age,
        if (length != null) 'length': length,
        'address': address.toJson(),
        'updated': updatedUTC.toIso8601String(),
      };
}

/// [PersonCollection] model with a list of [Person] model objects.
///
/// Sample source data as a JSON Array:
/// ```json
///   [
///     {
///       "name": "John Doe",
///       "age": 52,
///       "length": 1.75,
///       "address": { "street": "Main street", "city": "Anytown" },
///       "updated": "2021-08-09 09:00Z"
///     }
///   ]
/// ```
class PersonCollection {
  final Iterable<Person> persons;

  const PersonCollection({required this.persons});

  static PersonCollection fromJson(Iterable<dynamic> json) => PersonCollection(
        persons: json
            .map<Person>(
              (dynamic element) =>
                  Person.fromJson(element as Map<String, dynamic>),
            )
            .toList(growable: false),
      );

  List<dynamic> toJson() => persons
      .map<Map<String, dynamic>>((person) => person.toJson())
      .toList(growable: false);
}

void _decodeSampleData() {
  // Some json data as JSON Array.
  const jsonData = '''
  [
     { 
       "name": "John Doe",
       "age": 52,
       "length": 1.75,
       "address": { "street": "Main street", "city": "Anytown" },
       "updated": "2021-08-09 09:00Z"
     }
  ]
  ''';

  // Decode JSON and cast it to `Iterable<Object?>`.
  final decoded = json.decode(jsonData) as Iterable<dynamic>;

  // Map decoded objects to the domain model objects.
  final personCollection = PersonCollection.fromJson(decoded);

  // Use domain objects, here just print names and address info.
  for (final person in personCollection.persons) {
    print('${person.name} lives in ${person.address.street}');
  }

  // JSON data encoded from domain objects and outputted
  print(json.encode(personCollection.toJson()));
}
