import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SplashStatus enum', () {
    test('should return isLoading correctly for each status', () {
      expect(SplashStatus.initial.isLoading, true);
      expect(SplashStatus.loading.isLoading, true);
      expect(SplashStatus.authenticated.isLoading, false);
      expect(SplashStatus.unauthenticated.isLoading, false);
    });
    test('should return isAuthenticated correctly for each status', () {
      expect(SplashStatus.initial.isAuthenticated, false);
      expect(SplashStatus.loading.isAuthenticated, false);
      expect(SplashStatus.authenticated.isAuthenticated, true);
      expect(SplashStatus.unauthenticated.isAuthenticated, false);
    });
    test('should return isUnauthenticated correctly for each status', () {
      expect(SplashStatus.initial.isUnauthenticated, false);
      expect(SplashStatus.loading.isUnauthenticated, false);
      expect(SplashStatus.authenticated.isUnauthenticated, false);
      expect(SplashStatus.unauthenticated.isUnauthenticated, true);
    });
  });

  group('SplashState', () {
    test('should create initial state correctly', () {
      final state = SplashState.initial();

      expect(state.status, SplashStatus.initial);
      expect(state.message, isNull);
    });

    test('should copyWith correctly', () {
      final initial = SplashState.initial();
      final newState = initial.copyWith(
        status: SplashStatus.authenticated,
        message: 'any_message',
      );

      expect(newState.status, SplashStatus.authenticated);
      expect(newState.message, 'any_message');
    });

    test('should compare equality correctly', () {
      final initial = SplashState.initial();

      final newState = initial.copyWith(
        status: SplashStatus.authenticated,
        message: 'any_message',
      );

      final state1 = SplashState.initial();
      final state2 = SplashState.initial();

      expect(state1, equals(state2));
      expect(state1, isNot(equals(newState)));
    });

    test('props should include all properties', () {
      final state = SplashState.initial();
      final props = state.props;

      expect(props.length, 2);
      expect(props[0], SplashStatus.initial);
      expect(props[1], isNull);
    });
  });
}
