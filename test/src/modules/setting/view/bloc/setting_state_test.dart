import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SettingStatus enum', () {
    test('should return isLoading correctly for each status', () {
      expect(SettingStatus.initial.isLoading, true);
      expect(SettingStatus.loading.isLoading, true);
      expect(SettingStatus.updating.isLoading, false);
      expect(SettingStatus.updated.isLoading, false);
      expect(SettingStatus.success.isLoading, false);
      expect(SettingStatus.error.isLoading, false);
    });

    test('should return isSuccess correctly for each status', () {
      expect(SettingStatus.success.isSuccess, true);
      expect(SettingStatus.initial.isSuccess, false);
      expect(SettingStatus.loading.isSuccess, false);
      expect(SettingStatus.updating.isSuccess, false);
      expect(SettingStatus.updated.isSuccess, false);
      expect(SettingStatus.error.isSuccess, false);
    });
    test('should return isUpdating correctly for each status', () {
      expect(SettingStatus.success.isUpdating, false);
      expect(SettingStatus.initial.isUpdating, false);
      expect(SettingStatus.loading.isUpdating, false);
      expect(SettingStatus.updating.isUpdating, true);
      expect(SettingStatus.updated.isUpdating, false);
      expect(SettingStatus.error.isUpdating, false);
    });
    test('should return isUpdated correctly for each status', () {
      expect(SettingStatus.success.isUpdated, false);
      expect(SettingStatus.initial.isUpdated, false);
      expect(SettingStatus.loading.isUpdated, false);
      expect(SettingStatus.updating.isUpdated, false);
      expect(SettingStatus.updated.isUpdated, true);
      expect(SettingStatus.error.isUpdated, false);
    });
    test('should return isError correctly for each status', () {
      expect(SettingStatus.success.isError, false);
      expect(SettingStatus.initial.isError, false);
      expect(SettingStatus.loading.isError, false);
      expect(SettingStatus.updating.isError, false);
      expect(SettingStatus.updated.isError, false);
      expect(SettingStatus.error.isError, true);
    });
  });

  group('SettingState', () {
    test('should create initial state correctly', () {
      final state = SettingState.initial();

      expect(state.status, SettingStatus.initial);
      expect(state.users, isEmpty);
      expect(state.display, isNull);
      expect(state.message, isNull);
    });

    test('should copyWith correctly', () {
      final initial = SettingState.initial();
      final mockDisplay = TBL0005(showButtons: false);
      final mockPermissions = [TBL0004.instance()];

      final newState = initial.copyWith(
        status: SettingStatus.success,
        display: mockDisplay,
        users: mockPermissions,
        message: 'any_message',
      );

      expect(newState.status, SettingStatus.success);
      expect(newState.users, isNotEmpty);
      expect(newState.display, mockDisplay);
      expect(newState.message, 'any_message');
    });

    test('should compare equality correctly', () {
      final initial = SettingState.initial();
      final mockDisplay = TBL0005(showButtons: false);
      final mockPermissions = [TBL0004.instance()];

      final newState = initial.copyWith(
        status: SettingStatus.success,
        display: mockDisplay,
        users: mockPermissions,
        message: 'any_message',
      );

      final state1 = SettingState.initial();
      final state2 = SettingState.initial();

      expect(state1, equals(state2));
      expect(state1, isNot(equals(newState)));
    });

    test('props should include all properties', () {
      final state = SettingState.initial();
      final props = state.props;

      expect(props.length, 4);
      expect(props[0], SettingStatus.initial);
      expect(props[1], isEmpty);
      expect(props[2], isNull);
      expect(props[3], isNull);
    });
  });
}
