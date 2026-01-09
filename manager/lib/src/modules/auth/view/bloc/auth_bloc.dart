import '../../../../shared/export/app_export.dart';

class AuthBloc extends Cubit<AuthState> {
  final AuthService service;
  final PermissionService permissionService;
  final StorageService storageService;

  AuthBloc({
    required this.service,
    required this.permissionService,
    required this.storageService,
  }) : super(AuthState.initial());

  Future<void> load() async {
    emit(state.copyWith(status: AuthStatus.loading));

    try {
      emit(
        state.copyWith(
          status: AuthStatus.loaded,
          dto: AuthManagerDTO(
            email: storageService.getString('email'),
            password: storageService.getString('password'),
          ),
        ),
      );

      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          message: e.toString(),
        ),
      );
      return;
    }
  }

  Future<void> login(AuthManagerDTO credentials) async {
    try {
      emit(state.copyWith(status: AuthStatus.logging));

      if (!credentials.isValid) {
        emit(
          state.copyWith(
            status: AuthStatus.error,
            message: StringConstants.getString(4),
          ),
        );
        return;
      }

      final user = await service.login(credentials);

      await storageService.setString('email', user.email);

      emit(state.copyWith(status: AuthStatus.logged, user: user));

      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          message: e.toString(),
        ),
      );
      return;
    }
  }

  Future<void> signUp(AuthManagerDTO model) async {
    try {
      emit(state.copyWith(status: AuthStatus.registering));

      final newUser = await service.signUp(model);
      await permissionService.createPermission(
        TBL0004(
          id: '',
          user: newUser.id,
          type: 'professor',
          email: newUser.email,
          name: newUser.name,
        ),
      );

      emit(state.copyWith(status: AuthStatus.logged, user: newUser));

      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          message: e.toString(),
        ),
      );
      return;
    }
  }

  Future<void> logout() async {
    try {
      emit(state.copyWith(status: AuthStatus.loading));

      await service.logout();

      emit(state.copyWith(status: AuthStatus.disconnected));

      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: AuthStatus.error,
          message: e.toString(),
        ),
      );
      return;
    }
  }
}
