import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../mocks/mocks.mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late SplashBloc bloc;
  late SplashState initialState;

  setUp(() {
    mockAuthService = MockAuthService();
    bloc = SplashBloc(service: mockAuthService);
    initialState = SplashState.initial();
  });

  tearDown(() {
    bloc.close();
    reset(mockAuthService);
  });

  group(
    "SplashBloc - Tests for the initialize() method",
    () {
      blocTest<SplashBloc, SplashState>('should emit loading and authenticated states when initialized',
          setUp: () => when(mockAuthService.currentUser()).thenAnswer((_) async => Future.value(UserModel.instance())),
          build: () => bloc,
          act: (bloc) => bloc.initialize(),
          expect: () => [
                initialState.copyWith(status: SplashStatus.loading),
                initialState.copyWith(status: SplashStatus.authenticated),
              ]);
      blocTest<SplashBloc, SplashState>('should emit loading and unauthenticated states when initialized with error',
          setUp: () => when(mockAuthService.currentUser()).thenThrow(CustomException('any error', 500)),
          build: () => bloc,
          act: (bloc) => bloc.initialize(),
          expect: () => [
                initialState.copyWith(status: SplashStatus.loading),
                initialState.copyWith(status: SplashStatus.unauthenticated, message: 'any error'),
              ]);
    },
  );
}
