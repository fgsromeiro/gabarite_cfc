import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../fixture_reader.dart';

void main() {
  late Faker faker;
  late Map<String, dynamic> dataMap;
  late Map<String, dynamic> dataListMap;

  setUp(() {
    faker = Faker();
    dataMap = fixture('permission.json');
    dataListMap = fixture('list_of_permission.json');
  });

  group('PermissionExtension', () {
    test('should return true for isAdmin when type is admin', () {
      final permission = TBL0004(
        id: faker.guid.guid(),
        user: 'any_user',
        type: 'admin',
        email: faker.internet.email(),
        name: faker.person.name(),
      );

      expect(permission.isAdmin, true);
      expect(permission.isModerator, false);
      expect(permission.isTeacher, false);
      expect(permission.isProducts, false);
    });

    test('should return true for isModerator when type is moderador', () {
      final permission = TBL0004(
        id: faker.guid.guid(),
        user: 'user',
        type: 'moderador',
        email: faker.internet.email(),
        name: faker.person.name(),
      );

      expect(permission.isModerator, true);
      expect(permission.isAdmin, false);
    });

    test('should return true for isTeacher when type is professor', () {
      final permission = TBL0004(
        id: faker.guid.guid(),
        user: 'user3',
        type: 'professor',
        email: faker.internet.email(),
        name: faker.person.name(),
      );

      expect(permission.isTeacher, true);
      expect(permission.isAdmin, false);
    });

    test('should return true for isProducts when type is produtos', () {
      final permission = TBL0004(
        id: faker.guid.guid(),
        user: 'user4',
        type: 'produtos',
        email: faker.internet.email(),
        name: faker.person.name(),
      );

      expect(permission.isProducts, true);
      expect(permission.isAdmin, false);
    });
  });

  group('Permission', () {
    final permission = TBL0004(
      id: '1',
      user: 'any_id',
      type: 'admin',
      email: 'any_email',
      name: 'any_name',
    );

    test('should return the map correctly', () {
      final map = permission.toMap();

      expect(map, dataMap);
    });

    test('should create object correctly fromMap', () {
      final result = TBL0004.fromMap(dataMap);

      expect(result.id, '1');
      expect(result.user, 'any_id');
      expect(result.type, 'admin');
      expect(result.email, 'any_email');
      expect(result.name, 'any_name');
    });
    test('should convert list_of_permission.json to List<Permission>', () {
      final result = (dataListMap['permissions'] as List).map<TBL0004>((e) => TBL0004.fromMap(e)).toList();

      expect(result.length, 3);
      expect(result[0].id, '1');
      expect(result[0].user, 'user1');
      expect(result[0].type, 'admin');
      expect(result[0].email, 'user1@example.com');
      expect(result[0].name, 'User One');
    });

    test('should overwrite only passed fields in copyWith', () {
      final copy = permission.copyWith(email: 'new@mail.com');

      expect(copy, isA<TBL0004>());
      expect(identical(copy, permission), false);
    });

    test('copyWith returns same Permission if no params', () {
      final copied = permission.copyWith();
      expect(copied, permission);
    });

    test('equality and props', () {
      expect(permission.props, [
        '1',
        'any_id',
        'admin',
        'any_email',
        'any_name',
      ]);
    });
    test('should return empty object for instance', () {
      final instance = TBL0004.instance();

      expect(instance.id, '');
      expect(instance.user, '');
      expect(instance.type, '');
      expect(instance.email, '');
      expect(instance.name, '');
    });
  });
}
