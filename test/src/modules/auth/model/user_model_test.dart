import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture_reader.dart';

void main() {
  group('UserModel', () {
    final userModel = UserModel(
      id: 'any_id',
      email: 'any_email',
      name: 'any_name',
    );

    test('constructor assigns values', () {
      expect(userModel.id, 'any_id');
      expect(userModel.email, 'any_email');
      expect(userModel.name, 'any_name');
    });

    test('fromMap creates correct UserModel', () {
      final u = UserModel.fromMap(fixture('user_data.json'));

      expect(u.id, 'any_id');
      expect(u.email, 'any_email');
      expect(u.name, 'any_name');
    });

    test('instance() factory should return a UserModel with empty string values', () {
      final user = UserModel.instance();

      expect(user, isA<UserModel>());
      expect(user.id, '');
      expect(user.email, '');
      expect(user.name, '');
    });
  });
}
