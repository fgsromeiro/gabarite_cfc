import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class MenuBloc extends Cubit<MenuState> with ApplicationGlobalMixin {
  final AuthService service;
  final PermissionService permissionService;

  MenuBloc({
    required this.service,
    required this.permissionService,
  }) : super(MenuState.initial());

  Future<void> init(UserModel? user) async {
    try {
      emit(state.copyWith(status: MenuStatus.loading));

      final result = user ?? await service.currentUser();
      final permission = await permissionService.getPermission(
        SupabaseDTO(
          value: result.id,
          table: SupabaseUtils.kTBL0004,
          data: {},
          column: 'user_id',
        ),
      );

      emit(
        state.copyWith(
          status: MenuStatus.loaded,
          currentIndex: 0,
          user: result,
          permission: permission,
        ),
      );

      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: MenuStatus.error,
          message: StringConstants.getString(1),
        ),
      );

      return;
    }
  }

  Future<void> selectMenu(int index) async {
    emit(
      state.copyWith(
        status: MenuStatus.loaded,
        currentIndex: index,
      ),
    );
    return;
  }
}
