// Copyright (c) 2020-2023 Navibyte (https://navibyte.com). All rights reserved.
// Use of this source code is governed by a “BSD-3-Clause”-style license that is
// specified in the LICENSE file.
//
// Docs: https://github.com/navibyte/dataflow

// ignore_for_file: unnecessary_lambdas, avoid_catches_without_on_clauses
// ignore_for_file: prefer_const_constructors

import 'package:attributes/attributes.dart';

import 'package:test/test.dart';

Future<void> main() async {
  group('Test Identifier', () {
    test('Equality', () {
      expect(Identifier.from('id123'), Identifier.fromString('id123'));
      expect(Identifier.from('id123'), isNot(Identifier.fromString('id124')));
      expect(Identifier.from(123), Identifier.fromInt(123));
      expect(Identifier.from('123'), isNot(Identifier.fromInt(123)));
      expect(Identifier.from(BigInt.from(123)), isNot(Identifier.fromInt(123)));
      expect(Identifier.from(BigInt.two), Identifier.fromBigInt(BigInt.two));
    });
  });

  group('Test Entity', () {
    test('Equality', () {
      expect(
        Entity.view(
          id: 123,
          properties: {'some': 100, 'other': 'text'},
        ),
        EntityBase(
          id: Identifier.from(123),
          properties: DataObject.view({'some': 100, 'other': 'text'}),
        ),
      );
      expect(
        Entity.view(
          id: 123,
          properties: {'some': 100, 'other': 'text'},
        ),
        isNot(
          EntityBase(
            id: Identifier.from(123),
            properties: DataObject.view({'some': 101, 'other': 'text'}),
          ),
        ),
      );
      expect(
        Entity.view(
          id: 123,
          properties: {'some': 100, 'other': 'text'},
        ),
        isNot(
          EntityBase(
            id: Identifier.from(124),
            properties: DataObject.view({'some': 100, 'other': 'text'}),
          ),
        ),
      );
    });

    test('toString', () {
      expect(
        Entity.view(
          id: 123,
          properties: {'some': 100, 'other': 'text'},
        ).toString(),
        '{id: 123, properties: {some: 100, other: text}}',
      );
      expect(
        Entity.view(
          id: '123',
          properties: {
            'some': [100, 101],
            'other': 'text'
          },
        ).toString(),
        '{id: 123, properties: {some: [100, 101], other: text}}',
      );
    });

    test('encodeJson', () {
      final obj1 = Entity.view(
        id: 123,
        properties: {
          'some': 100,
          'other': 'text',
          'date': DateTime(2020, 10, 02),
        },
      );
      const json1 = '{"id":"123","properties":{"some":100,"other":"text",'
          '"date":"2020-10-02T00:00:00.000"}}';
      expect(obj1.encodeJson(), json1);
      expect(Entity.decodeJson(json1).encodeJson(), json1);
      final obj2 = Entity.view(
        id: '123',
        properties: {
          'some': [100, 101],
          'other': 'text',
          'date': DateTime(2020, 10, 02),
        },
      );
      const json2 = '{"id":"123","properties":{"some":[100,101],"other":"text",'
          '"date":2020}}';
      expect(obj2.encodeJson(encodeTime: (date) => date.year), json2);
      expect(Entity.decodeJson(json2).encodeJson(), json2);
    });
  });

  group('Test DataArray', () {
    test('DataArray views', () {
      final source = [1, 2, 3];
      final immutable = DataArray.of(source);
      final view = DataArray.view(source);
      source[1] = 20;
      expect(source[1], 20);
      expect(immutable[1], 2);
      expect(view[1], 20);
      source.add(4);
      expect(source.length, 4);
      expect(immutable.length, 3);
      expect(view.length, 4);
      source.clear();
      expect(source.length, 0);
      expect(immutable.length, 3);
      expect(view.length, 0);
    });

    test('DataArray iterable accessors', () {
      final p1 = [
        DataArray.of(<int>[0, 10, 20, 30, 40]),
        DataArray.view(<int>[0, 10, 20, 30, 40]),
        DataArray.view(<int?>[0, 10, 20, 30, 40]),
        DataArray.decodeJson('[0, 10, 20, 30, 40]'),
      ];
      for (final p in p1) {
        expect(p.toValues(), [0, 10, 20, 30, 40]);
        expect(p.toValues<int>(), [0, 10, 20, 30, 40]);
        expect(p.toValues<BigInt>(), [
          BigInt.from(0),
          BigInt.from(10),
          BigInt.from(20),
          BigInt.from(30),
          BigInt.from(40)
        ]);
        expect(p.toValues<num>(), <num>[0, 10, 20, 30, 40]);
        expect(p.toValues<double>(), [0.0, 10.0, 20.0, 30.0, 40.0]);
        expect(p.toValues<String>(), ['0', '10', '20', '30', '40']);
        expect(p.toValues<bool>(), [false, true, true, true, true]);
      }
      final p2 = [
        DataArray.of([0, 10, 20, 30, null]),
        DataArray.view(<int?>[0, 10, 20, 30, null]),
        DataArray.decodeJson('[0, 10, 20, 30, null]'),
      ];
      for (final p in p2) {
        expect(() => p.toValues<int>(), throwsFormatException);
        expect(() => p.toValues<BigInt>(), throwsFormatException);
        expect(() => p.toValues<num>(), throwsFormatException);
        expect(() => p.toValues<double>(), throwsFormatException);
        expect(() => p.toValues<String>(), throwsFormatException);
        expect(() => p.toValues<bool>(), throwsFormatException);
        expect(p.toNullableValues(), [0, 10, 20, 30, null]);
        expect(p.toNullableValues<int>(), [0, 10, 20, 30, null]);
        expect(p.toNullableValues<BigInt>(), [
          BigInt.from(0),
          BigInt.from(10),
          BigInt.from(20),
          BigInt.from(30),
          null
        ]);
        expect(p.toNullableValues<num>(), <num?>[0, 10, 20, 30, null]);
        expect(p.toNullableValues<double>(), [0.0, 10.0, 20.0, 30.0, null]);
        expect(p.toNullableValues<String>(), ['0', '10', '20', '30', null]);
        expect(p.toNullableValues<bool>(), [false, true, true, true, null]);
      }
    });

    test('toString', () {
      expect(
        DataArray.view(
          [
            'foo',
            45,
            {'some': 100, 'other': 'text'}
          ],
        ).toString(),
        '[foo, 45, {some: 100, other: text}]',
      );
      expect(
        DataArray.view(
          [
            true,
            {
              'some': [100, 101],
              'other': 'text'
            },
          ],
        ).toString(),
        '[true, {some: [100, 101], other: text}]',
      );
    });

    test('encodeJson and decodeJson', () {
      final obj1 = DataArray.view(
        [
          {'x': 10.1, 'y': 20.1},
          {
            'some': 100,
            'other': 'text',
            'date': DateTime(2020, 10, 02),
          },
        ],
      );
      const json1 = '[{"x":10.1,"y":20.1},{"some":100,"other":"text",'
          '"date":"2020-10-02T00:00:00.000"}]';
      expect(obj1.encodeJson(), json1);
      expect(DataArray.decodeJson(json1).encodeJson(), json1);
      final obj2 = DataArray.view(
        [
          [10.1, 20.1],
          {
            'some': [100, 101],
            'other': 'text',
            'date': DateTime(2020, 10, 02),
          },
        ],
      );
      const json2 = '[[10.1,20.1],{"some":[100,101],"other":"text",'
          '"date":2020}]';
      expect(obj2.encodeJson(encodeTime: (date) => date.year), json2);
      expect(DataArray.decodeJson(json2).encodeJson(), json2);
    });
  });

  group('Test DataObject', () {
    test('DataObject views', () {
      final source = <String, Object?>{'foo': 1, 'bar': 2};
      final immutable = DataObject.of(source);
      final view = DataObject.view(source);
      source['foo'] = 10;
      expect(source['foo'], 10);
      expect(immutable['foo'], 1);
      expect(view['foo'], 10);
      expect(view['bar'], 2);
    });

    test('DataObject map accessors', () {
      final p1 = [
        DataObject.of({'foo': 1, 'bar': 2}),
        DataObject.view({'foo': 1, 'bar': 2}),
        DataObject.decodeJson('{"foo": 1, "bar": 2}'),
      ];
      for (final p in p1) {
        expect(p.toValueMap(), {'foo': 1, 'bar': 2});
        expect(p.toValueMap<int>(), {'foo': 1, 'bar': 2});
        expect(
          p.toValueMap<BigInt>(),
          {'foo': BigInt.from(1), 'bar': BigInt.from(2)},
        );
        expect(p.toValueMap<num>(), <String, num>{'foo': 1, 'bar': 2});
        expect(p.toValueMap<double>(), {'foo': 1.0, 'bar': 2.0});
        expect(p.toValueMap<String>(), {'foo': '1', 'bar': '2'});
        expect(p.toValueMap<bool>(), {'foo': true, 'bar': true});
        expect(p.toNullableValueMap(), {'foo': 1, 'bar': 2});
        expect(p.toNullableValueMap<int>(), {'foo': 1, 'bar': 2});
        expect(
          p.toNullableValueMap<BigInt>(),
          {'foo': BigInt.from(1), 'bar': BigInt.from(2)},
        );
        expect(p.toNullableValueMap<num>(), <String, num>{'foo': 1, 'bar': 2});
        expect(p.toNullableValueMap<double>(), {'foo': 1.0, 'bar': 2.0});
        expect(p.toNullableValueMap<String>(), {'foo': '1', 'bar': '2'});
        expect(p.toNullableValueMap<bool>(), {'foo': true, 'bar': true});
      }
      final p2 = [
        DataObject.of({'foo': 1, 'bar': 2, 'baz': null}),
        DataObject.view({'foo': 1, 'bar': 2, 'baz': null}),
        DataObject.decodeJson('{"foo": 1, "bar": 2, "baz": null}'),
      ];
      for (final p in p2) {
        expect(() => p.toValueMap(), throwsFormatException);
        expect(() => p.toValueMap<int>(), throwsFormatException);
        expect(() => p.toValueMap<BigInt>(), throwsFormatException);
        expect(() => p.toValueMap<num>(), throwsFormatException);
        expect(() => p.toValueMap<double>(), throwsFormatException);
        expect(() => p.toValueMap<String>(), throwsFormatException);
        expect(() => p.toValueMap<bool>(), throwsFormatException);
        expect(p.toNullableValueMap(), {'foo': 1, 'bar': 2, 'baz': null});
        expect(p.toNullableValueMap<int>(), {'foo': 1, 'bar': 2, 'baz': null});
        expect(
          p.toNullableValueMap<BigInt>(),
          {'foo': BigInt.from(1), 'bar': BigInt.from(2), 'baz': null},
        );
        expect(
          p.toNullableValueMap<num>(),
          <String, num?>{'foo': 1, 'bar': 2, 'baz': null},
        );
        expect(
          p.toNullableValueMap<double>(),
          {'foo': 1.0, 'bar': 2.0, 'baz': null},
        );
        expect(
          p.toNullableValueMap<String>(),
          {'foo': '1', 'bar': '2', 'baz': null},
        );
        expect(
          p.toNullableValueMap<bool>(),
          {'foo': true, 'bar': true, 'baz': null},
        );
      }
    });

    test('toString', () {
      expect(
        DataObject.view(
          {'some': 100, 'other': 'text'},
        ).toString(),
        '{some: 100, other: text}',
      );
      expect(
        DataObject.view(
          {
            'some': [100, 101],
            'other': 'text'
          },
        ).toString(),
        '{some: [100, 101], other: text}',
      );
    });

    test('encodeJson and decodeJson', () {
      final obj1 = DataObject.view(
        {
          'some': 100,
          'other': 'text',
          'date': DateTime(2020, 10, 02),
        },
      );
      const json1 = '{"some":100,"other":"text",'
          '"date":"2020-10-02T00:00:00.000"}';
      expect(obj1.encodeJson(), json1);
      expect(DataObject.decodeJson(json1).encodeJson(), json1);
      final obj2 = DataObject.view(
        {
          'some': [100, 101],
          'other': 'text',
          'date': DateTime(2020, 10, 02),
        },
      );
      const json2 = '{"some":[100,101],"other":"text",'
          '"date":2020}';
      expect(obj2.encodeJson(encodeTime: (date) => date.year), json2);
      expect(DataObject.decodeJson(json2).encodeJson(), json2);
    });
  });

  group('Test DataObject with sample data', () {
    test('PropertyMap in different ways', () {
      final json = DataObject.decodeJson(_sampleJson);
      final dataView = DataObject.view(_sampleData);
      final dynView = DataObject.view(_sampleDynamic);
      final dataUnmod = DataObject.of(_sampleData);
      final dynUnmod = DataObject.of(_sampleDynamic);

      expect(json, dataView);
      expect(json, dynView);
      expect(dataView, dynView);
      expect(dataView, dataUnmod);
      expect(dynView, dynUnmod);
      expect(_sampleData is Map<String, Object>, false);
    });

    test('DataObject from Map<String, Object?>', () {
      final data = DataObject.view(_sampleData);
      final dataNonNull = DataObject.view(_sampleNonNull);
      _checkData(data);
      _checkData(dataNonNull, omitNull: true);
    });

    test('DataObject from Map<String, String?>', () {
      final data = DataObject.view(_typedData);
      _checkData(data, omitSubStructures: true);
    });
  });
}

void _checkData(
  DataObject data, {
  bool omitSubStructures = false,
  bool omitNull = false,
}) {
  expect(data.getString('string'), 'a String');

  expect(data.getInt('int'), 100);
  expect(data.exists('double'), true);
  expect(data.getDouble('double'), 123.45);
  expect(data.getBool('bool'), true);
  expect(data.exists('bool2'), false);
  expect(data.getString('date'), '2020-10-01 00:00Z');
  // ignore: avoid_redundant_argument_values
  expect(data.getTimeUTC('date'), DateTime.utc(2020, 10, 01));
  expect(data.getTimeUTC('time'), DateTime.utc(2020, 10, 01, 10, 01));
  if (!omitSubStructures) {
    expect(data.object('map'), DataObject.of({'foo': 'bar'}));
    expect(data.array('list'), DataArray.of([1, 2, 3, 4, 5]));
  }
  if (omitNull) {
    expect(data.exists('null'), false);
    expect(data.existsNonNull('null'), false);
    expect(data.existsNull('null'), false);
  } else {
    expect(data.exists('null'), true);
    expect(data.existsNonNull('null'), false);
    expect(data.existsNull('null'), true);
  }
}

// sample as encoded JSON text
const _sampleJson = '''
    {
      "string": "a String",
      "int": 100,
      "double": 123.45,
      "bool": true,
      "date": "2020-10-01 00:00Z",
      "time": "2020-10-01 10:01Z",
      "map": {
        "foo": "bar"
      },
      "list": [1, 2, 3, 4, 5],
      "null": null
    }
  ''';

// sample as `Map<String, Object?>
const _sampleData = {
  'string': 'a String',
  'int': 100,
  'double': 123.45,
  'bool': true,
  'date': '2020-10-01 00:00Z',
  'time': '2020-10-01 10:01Z',
  'map': {'foo': 'bar'},
  'list': [1, 2, 3, 4, 5],
  'null': null,
};

// sample as `Map<String, Object>
const _sampleNonNull = {
  'string': 'a String',
  'int': 100,
  'double': 123.45,
  'bool': true,
  'date': '2020-10-01 00:00Z',
  'time': '2020-10-01 10:01Z',
  'map': {'foo': 'bar'},
  'list': [1, 2, 3, 4, 5],
};

// sample as `Map<String, dynamic>
const _sampleDynamic = <String, dynamic>{
  'string': 'a String',
  'int': 100,
  'double': 123.45,
  'bool': true,
  'date': '2020-10-01 00:00Z',
  'time': '2020-10-01 10:01Z',
  'map': {'foo': 'bar'},
  'list': [1, 2, 3, 4, 5],
  'null': null,
};

// sample as `Map<String, String?>
const _typedData = <String, String?>{
  'string': 'a String',
  'int': '100',
  'double': '123.45',
  'bool': 'true',
  'date': '2020-10-01 00:00Z',
  'time': '2020-10-01 10:01Z',
  'null': null,
};
