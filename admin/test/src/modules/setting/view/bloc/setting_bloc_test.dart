import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../../fixture_reader.dart';
import '../../../../../mocks/mocks.mocks.dart';

void main() {
  late MockSettingService mockSettingService;
  late MockPermissionService mockPermissionService;
  late MockNoteService mockNoteService;
  late SettingBloc bloc;
  late Map<String, dynamic> mockResponseListPermission;
  late Map<String, dynamic> mockResponseNote;
  late Map<String, dynamic> mockResponseDisplay;
  late Map<String, dynamic> mockResponsePermission;

  setUp(() {
    mockSettingService = MockSettingService();
    mockPermissionService = MockPermissionService();
    mockNoteService = MockNoteService();
    mockResponseListPermission = fixture('list_of_permission.json');
    mockResponseNote = fixture('note.json');
    mockResponsePermission = fixture('permission.json');
    mockResponseDisplay = {'showButtons': false};
    bloc = SettingBloc(
      service: mockSettingService,
      noteService: mockNoteService,
      permissionService: mockPermissionService,
    );
  });

  tearDown(() {
    bloc.close();
    reset(mockSettingService);
    reset(mockPermissionService);
    reset(mockNoteService);
  });

  group('SettingBloc - Tests for the load() method', () {
    late TBL0005 mockDisplay;
    late List<TBL0004> mockPermissionsList;
    late SettingState initialState;

    setUp(() {
      mockDisplay = TBL0005.fromMap(mockResponseDisplay);
      mockPermissionsList = (mockResponseListPermission['permissions'] as List).map((e) => TBL0004.fromMap(e)).toList();
      initialState = SettingState.initial();
    });

    blocTest<SettingBloc, SettingState>(
      'should issue a new state with the list of questions by successfully carrying',
      setUp: () {
        when(mockSettingService.getToggleButtons()).thenAnswer((_) async => mockDisplay);
        when(mockPermissionService.findAllPermissionsUsers()).thenAnswer((_) async => mockPermissionsList);
      },
      build: () => bloc,
      act: (bloc) => bloc.load(),
      expect: () => [
        initialState.copyWith(status: SettingStatus.loading),
        initialState.copyWith(
          status: SettingStatus.success,
          display: mockDisplay,
          users: mockPermissionsList,
        ),
      ],
      verify: (bloc) {
        verify(mockSettingService.getToggleButtons()).called(1);
        verify(mockPermissionService.findAllPermissionsUsers()).called(1);
        expect(bloc.state.status, SettingStatus.success);
      },
    );

    blocTest<SettingBloc, SettingState>(
      'should emit a new error state when failing to call the getToggleButtons() method',
      setUp: () {
        when(mockSettingService.getToggleButtons()).thenThrow(CustomException('any_message', 500));
      },
      build: () => bloc,
      act: (bloc) => bloc.load(),
      expect: () => [
        initialState.copyWith(status: SettingStatus.loading),
        initialState.copyWith(status: SettingStatus.error, message: 'any_message'),
      ],
      verify: (bloc) {
        verify(mockSettingService.getToggleButtons()).called(1);
        verifyNever(mockPermissionService.findAllPermissionsUsers());
        expect(bloc.state.status, SettingStatus.error);
        expect(bloc.state.message, 'any_message');
      },
    );
    blocTest<SettingBloc, SettingState>(
      'should emit a new error state when failing to call the findAllPermissionsUsers() method',
      setUp: () {
        when(mockSettingService.getToggleButtons()).thenAnswer((_) async => mockDisplay);
        when(mockPermissionService.findAllPermissionsUsers()).thenThrow(CustomException('any_message', 500));
      },
      build: () => bloc,
      act: (bloc) => bloc.load(),
      expect: () => [
        initialState.copyWith(status: SettingStatus.loading),
        initialState.copyWith(status: SettingStatus.error, message: 'any_message'),
      ],
      verify: (bloc) {
        verify(mockSettingService.getToggleButtons()).called(1);
        verify(mockPermissionService.findAllPermissionsUsers()).called(1);
        expect(bloc.state.status, SettingStatus.error);
        expect(bloc.state.message, 'any_message');
      },
    );
  });
  group('SettingBloc - Tests for the reset() method', () {
    late SettingState initialState;
    late TBL0001 mockNote;

    setUp(() {
      initialState = SettingState.initial();
      mockNote = TBL0001.fromMap(mockResponseNote);
    });

    blocTest<SettingBloc, SettingState>(
      'should emit a new success state when calling the reset() method successfully',
      setUp: () {
        when(mockSettingService.reset()).thenAnswer((_) async => Future.value());
      },
      build: () => bloc,
      act: (bloc) => bloc.reset(mockNote),
      expect: () => [
        initialState.copyWith(status: SettingStatus.loading),
        initialState.copyWith(status: SettingStatus.success),
      ],
      verify: (bloc) {
        verify(mockSettingService.reset()).called(1);
        expect(bloc.state.status, SettingStatus.success);
      },
    );

    blocTest<SettingBloc, SettingState>(
      'should emit a new error state when failing to call the reset() method',
      setUp: () {
        when(mockSettingService.reset()).thenThrow(CustomException('any_message', 500));
      },
      build: () => bloc,
      act: (bloc) => bloc.reset(mockNote),
      expect: () => [
        initialState.copyWith(status: SettingStatus.loading),
        initialState.copyWith(status: SettingStatus.error, message: 'any_message'),
      ],
      verify: (bloc) {
        verify(mockSettingService.reset()).called(1);
        expect(bloc.state.status, SettingStatus.error);
        expect(bloc.state.message, 'any_message');
      },
    );
  });
  group('SettingBloc - Tests for the updatePermission() method', () {
    late SettingState initialState;
    late TBL0004 mockPermission;

    setUp(() {
      initialState = SettingState.initial();
      mockPermission = TBL0004.fromMap(mockResponsePermission);
    });

    blocTest<SettingBloc, SettingState>(
      'should emit a new success state when calling the updatePermission() method successfully',
      setUp: () {
        when(mockPermissionService.updatePermission(mockPermission)).thenAnswer((_) async => Future.value());
      },
      build: () => bloc,
      act: (bloc) => bloc.updatePermission(mockPermission),
      expect: () => [
        initialState.copyWith(status: SettingStatus.updating),
        initialState.copyWith(status: SettingStatus.updated),
      ],
      verify: (bloc) {
        verify(mockPermissionService.updatePermission(mockPermission)).called(1);
        expect(bloc.state.status, SettingStatus.updated);
      },
    );

    blocTest<SettingBloc, SettingState>(
      'should emit a new error state when failing to call the updatePermission() method',
      setUp: () {
        when(mockPermissionService.updatePermission(mockPermission)).thenThrow(CustomException('any_message', 500));
      },
      build: () => bloc,
      act: (bloc) => bloc.updatePermission(mockPermission),
      expect: () => [
        initialState.copyWith(status: SettingStatus.updating),
        initialState.copyWith(status: SettingStatus.error, message: 'any_message'),
      ],
      verify: (bloc) {
        verify(mockPermissionService.updatePermission(mockPermission)).called(1);
        expect(bloc.state.status, SettingStatus.error);
        expect(bloc.state.message, 'any_message');
      },
    );
  });
  group('SettingBloc - Tests for the updateDisplay() method', () {
    late SettingState initialState;
    late TBL0005 mockDisplay;

    setUp(() {
      initialState = SettingState.initial();
      mockDisplay = TBL0005.fromMap(mockResponseDisplay);
    });

    blocTest<SettingBloc, SettingState>(
      'should emit a new success state when calling the updateDisplay() method successfully',
      setUp: () {
        when(mockSettingService.toggleButtons(mockDisplay)).thenAnswer((_) async => Future.value());
      },
      build: () => bloc,
      act: (bloc) => bloc.updateDisplay(mockDisplay),
      expect: () => [
        initialState.copyWith(status: SettingStatus.updating),
        initialState.copyWith(status: SettingStatus.updated),
      ],
      verify: (bloc) {
        verify(mockSettingService.toggleButtons(mockDisplay)).called(1);
        expect(bloc.state.status, SettingStatus.updated);
      },
    );

    blocTest<SettingBloc, SettingState>(
      'should emit a new error state when failing to call the updateDisplay() method',
      setUp: () {
        when(mockSettingService.toggleButtons(mockDisplay)).thenThrow(CustomException('any_message', 500));
      },
      build: () => bloc,
      act: (bloc) => bloc.updateDisplay(mockDisplay),
      expect: () => [
        initialState.copyWith(status: SettingStatus.updating),
        initialState.copyWith(status: SettingStatus.error, message: 'any_message'),
      ],
      verify: (bloc) {
        verify(mockSettingService.toggleButtons(mockDisplay)).called(1);
        expect(bloc.state.status, SettingStatus.error);
        expect(bloc.state.message, 'any_message');
      },
    );
  });
}
