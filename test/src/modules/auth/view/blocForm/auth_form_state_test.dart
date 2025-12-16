import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

void main() {
  group('AuthFormState', () {
    final initialFormState = AuthFormState.initial();
    const baseFormState = AuthFormState(email: 'any_email', password: 'any_password', name: 'any_user');

    test('AuthFormState.initial() must have all fields empty', () {
      expect(initialFormState.email, '');
      expect(initialFormState.password, '');
      expect(initialFormState.name, '');
    });

    test('two instances with the same values must be equal', () {
      const state1 = AuthFormState(email: 'a', password: 'b', name: 'c');
      const state2 = AuthFormState(email: 'a', password: 'b', name: 'c');
      expect(state1, state2);
    });

    test('copyWith must update only the email', () {
      final updatedState = baseFormState.copyWith(email: 'new_email@email.com');

      expect(updatedState.email, 'new_email@email.com');
      expect(updatedState.password, baseFormState.password);
      expect(updatedState.name, baseFormState.name);
    });

    test('copyWith must update multiple fields', () {
      final updatedState = baseFormState.copyWith(
        email: 'changed@email.com',
        name: 'New Name',
      );

      expect(updatedState.email, 'changed@email.com');
      expect(updatedState.password, baseFormState.password);
      expect(updatedState.name, 'New Name');
    });

    test('copyWith without parameters must return an identical copy', () {
      final updatedState = baseFormState.copyWith();

      expect(updatedState.email, baseFormState.email);
      expect(updatedState.password, baseFormState.password);
      expect(updatedState.name, baseFormState.name);

      expect(updatedState, isNot(same(baseFormState)));
    });
  });
}
