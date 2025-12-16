import '../../../../shared/export/app_export.dart';

class SettingBloc extends Cubit<SettingState> {
  final SettingService service;
  final PermissionService permissionService;
  final NoteService noteService;

  SettingBloc({
    required this.service,
    required this.noteService,
    required this.permissionService,
  }) : super(SettingState.initial());

  Future<void> load() async {
    try {
      emit(state.copyWith(status: SettingStatus.loading));

      final display = await service.getToggleButtons();
      final users = await permissionService.findAllPermissionsUsers();

      emit(
        state.copyWith(
          status: SettingStatus.success,
          display: display,
          users: users,
        ),
      );

      return;
    } catch (e) {
      emit(state.copyWith(status: SettingStatus.error, message: e.toString()));
      return;
    }
  }

  Future<void> reset(TBL0001 note) async {
    try {
      emit(state.copyWith(status: SettingStatus.loading));

      await service.reset();

      emit(
        state.copyWith(
          status: SettingStatus.success,
        ),
      );

      return;
    } catch (e) {
      emit(state.copyWith(status: SettingStatus.error, message: e.toString()));
      return;
    }
  }

  Future<void> updatePermission(TBL0004 permission) async {
    try {
      emit(state.copyWith(status: SettingStatus.updating));

      await permissionService.updatePermission(permission);

      emit(state.copyWith(status: SettingStatus.updated));

      return;
    } catch (e) {
      emit(state.copyWith(status: SettingStatus.error, message: e.toString()));
      return;
    }
  }

  Future<void> updateDisplay(TBL0005 display) async {
    try {
      emit(state.copyWith(status: SettingStatus.updating));

      await service.toggleButtons(display);

      emit(state.copyWith(status: SettingStatus.updated));

      return;
    } catch (e) {
      emit(state.copyWith(status: SettingStatus.error, message: e.toString()));
      return;
    }
  }
}
