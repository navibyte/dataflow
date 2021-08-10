// Copyright (c) 2020-2021 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

/*
To test run this from command line: 

dart example/data_object_example.dart
*/

import 'package:attributes/data.dart';

void main() {
  _decodeSampleData();
}

/// [Address] is a simple data object with [street] and [city] fields.
///
/// Sample source data as a JSON Object:
/// `{ "street": "Main street", "city": "Anytown" }`
class Address {
  final String street;
  final String city;

  const Address({required this.street, required this.city});

  factory Address.fromData(DataObject data) => Address(
        street: data.getString('street'),
        city: data.getString('city'),
      );

  DataObject toData() => DataObject.of({
        'street': street,
        'city': city,
      });
}

/// [Person] with [name], [age], an optional [length] and aggregated [address].
///
/// Sample source data as a JSON Object:
/// ```json
///   {
///     "name": "John Smith",
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

  const Person(
      {required this.name,
      required this.age,
      this.length,
      required this.address,
      required this.updatedUTC});

  factory Person.fromData(DataObject data) => Person(
      name: data.getString('name'),
      age: data.getInt('age'),
      length: data.tryDouble('length'),
      address: Address.fromData(data.object('address')),
      updatedUTC: data.getTimeUTC('updated'));

  DataObject toData() => DataObject.of({
        'name': name,
        'age': age,
        if (length != null) 'length': length,
        'address': address.toData(),
        'updated': updatedUTC,
      });
}

/// [PersonCollection] is a data array with a list of [Person] data objects.
///
/// Sample source data as a JSON Array:
/// ```json
///   [
///     {
///       "name": "John Smith",
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

  factory PersonCollection.fromData(DataArray data) => PersonCollection(
        persons: data.objects
            .map((element) => Person.fromData(element))
            .toList(growable: false),
      );

  DataArray toData() => DataArray.of(
        persons.map((person) => person.toData()).toList(growable: false),
      );
}

void _decodeSampleData() {
  // Some json data as JSON Array.
  const jsonData = '''
  [
     { 
       "name": "John Smith",
       "age": 52,
       "length": 1.75,
       "address": { "street": "Main street", "city": "Anytown" },
       "updated": "2021-08-09 09:00Z"
     }
  ]
  ''';

  // Decode JSON using DataArray.
  final decoded = DataArray.decodeJson(jsonData);

  // Map decoded objects to the domain model objects.
  final personCollection = PersonCollection.fromData(decoded);

  // Use domain objects, here just print names and address info.
  for (final person in personCollection.persons) {
    print('${person.name} lives in ${person.address.street}');
  }

  // JSON data encoded from domain objects and outputted
  print(personCollection.toData().encodeJson());
}
