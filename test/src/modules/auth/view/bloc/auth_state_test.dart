import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AuthStatusX', () {
    group('isLoading', () {
      test('should return true to authstatus.initial and authstatus.loading', () {
        expect(AuthStatus.initial.isLoading, isTrue);
        expect(AuthStatus.loading.isLoading, isTrue);
      });

      test('should return false to other statuses', () {
        expect(AuthStatus.loaded.isLoading, isFalse);
        expect(AuthStatus.logged.isLoading, isFalse);
        expect(AuthStatus.error.isLoading, isFalse);
        expect(AuthStatus.disconnected.isLoading, isFalse);
        expect(AuthStatus.logging.isLoading, isFalse);
        expect(AuthStatus.registering.isLoading, isFalse);
      });
    });

    group('isLoaded', () {
      test('should return true to AuthStatus.loaded', () {
        expect(AuthStatus.loaded.isLoaded, isTrue);
      });

      test('should return false to other statuses', () {
        expect(AuthStatus.initial.isLoaded, isFalse);
        expect(AuthStatus.loading.isLoaded, isFalse);
        expect(AuthStatus.logged.isLoaded, isFalse);
        expect(AuthStatus.error.isLoaded, isFalse);
      });
    });

    group('isLogging', () {
      test('should return true to AuthStatus.logging', () {
        expect(AuthStatus.logging.isLogging, isTrue);
      });

      test('should return false to other statuses', () {
        expect(AuthStatus.initial.isLogging, isFalse);
        expect(AuthStatus.logged.isLogging, isFalse);
        expect(AuthStatus.error.isLogging, isFalse);
      });
    });

    group('isRegistering', () {
      test('should return true to AuthStatus.registering', () {
        expect(AuthStatus.registering.isRegistering, isTrue);
      });

      test('should return false to other statuses', () {
        expect(AuthStatus.initial.isRegistering, isFalse);
        expect(AuthStatus.logged.isRegistering, isFalse);
        expect(AuthStatus.error.isRegistering, isFalse);
      });
    });

    group('isLogged', () {
      test('should return true to AuthStatus.logged', () {
        expect(AuthStatus.logged.isLogged, isTrue);
      });

      test('should return false to other statuses', () {
        expect(AuthStatus.initial.isLogged, isFalse);
        expect(AuthStatus.loading.isLogged, isFalse);
        expect(AuthStatus.loaded.isLogged, isFalse);
        expect(AuthStatus.error.isLogged, isFalse);
      });
    });

    group('isError', () {
      test('should return true to AuthStatus.error', () {
        expect(AuthStatus.error.isError, isTrue);
      });

      test('should return false to other statuses', () {
        expect(AuthStatus.initial.isError, isFalse);
        expect(AuthStatus.loaded.isError, isFalse);
        expect(AuthStatus.logged.isError, isFalse);
        expect(AuthStatus.disconnected.isError, isFalse);
      });
    });

    group('isDisconnected', () {
      test('should return true to AuthStatus.disconnected', () {
        expect(AuthStatus.disconnected.isDisconnected, isTrue);
      });

      test('should return false to other statuses', () {
        expect(AuthStatus.initial.isDisconnected, isFalse);
        expect(AuthStatus.loading.isDisconnected, isFalse);
        expect(AuthStatus.loaded.isDisconnected, isFalse);
        expect(AuthStatus.logged.isDisconnected, isFalse);
      });
    });
  });

  group('AuthState', () {
    final initialUserState = AuthState(
      status: AuthStatus.initial,
      user: UserModel.instance(),
      message: 'Initial message',
    );

    test('copyWith should only update the status', () {
      final updatedState = initialUserState.copyWith(status: AuthStatus.logged);

      expect(updatedState.status, AuthStatus.logged);

      expect(updatedState.user, initialUserState.user);
      expect(updatedState.message, initialUserState.message);
    });

    test('copyWith should update multiple fields', () {
      final updatedState = initialUserState.copyWith(
        status: AuthStatus.error,
        message: 'Something went wrong',
      );

      expect(updatedState.status, AuthStatus.error);
      expect(updatedState.message, 'Something went wrong');

      expect(updatedState.user, initialUserState.user);
    });

    test('copyWith should return an identical copy if no fields are provided', () {
      final updatedState = initialUserState.copyWith();

      expect(updatedState.status, initialUserState.status);
      expect(updatedState.user, initialUserState.user);
      expect(updatedState.message, initialUserState.message);
    });
  });
}
