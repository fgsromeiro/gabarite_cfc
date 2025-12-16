import '../../../../shared/export/app_export.dart';

class SplashBloc extends Cubit<SplashState> {
  final AuthService service;

  SplashBloc({
    required this.service,
  }) : super(SplashState.initial());

  Future<void> initialize() async {
    try {
      emit(state.copyWith(status: SplashStatus.loading));

      await service.currentUser();

      emit(state.copyWith(status: SplashStatus.authenticated));

      return;
    } on CustomException catch (e) {
      emit(
        state.copyWith(
          message: e.message,
          status: SplashStatus.unauthenticated,
        ),
      );
      return;
    }
  }
}
