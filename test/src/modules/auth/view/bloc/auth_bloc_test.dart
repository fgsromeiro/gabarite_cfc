
import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../mocks/mocks.mocks.dart';

void main() {
  late MockAuthService mockAuthService;
  late MockPermissionService mockPermissionService;
  late MockStorageService mockStorageService;
  late UserModel user;
  late AuthBloc authBloc;

  setUp(() {
    mockAuthService = MockAuthService();
    mockPermissionService = MockPermissionService();
    mockStorageService = MockStorageService();
    user = UserModel(id: 'any_id', email: 'any_email', name: 'any_name');

    authBloc = AuthBloc(
      service: mockAuthService,
      permissionService: mockPermissionService,
      storageService: mockStorageService,
    );
  });

  tearDown(() {
    authBloc.close();
    reset(mockAuthService);
    reset(mockPermissionService);
    reset(mockStorageService);
  });

  group('AuthBloc - Tests for the load() method', () {
    blocTest<AuthBloc, AuthState>(
      'should issue a new state with the authManagerDTO by successfully carrying',
      setUp: () {
        when(mockStorageService.getString('email')).thenReturn('teste@email.com');
        when(mockStorageService.getString('password')).thenReturn('senha123');
      },
      build: () => authBloc,
      act: (bloc) => bloc.load(),
      expect: () => [
        AuthState(status: AuthStatus.loading),
        AuthState(
          status: AuthStatus.loaded,
          dto: AuthManagerDTO(email: 'teste@email.com', password: 'senha123'),
        ),
      ],
      verify: (bloc) {
        verify(mockStorageService.getString('email')).called(1);
        verify(mockStorageService.getString('password')).called(1);
        expect(bloc.state.status, AuthStatus.loaded);
        expect(bloc.state.dto?.email, 'teste@email.com');
        expect(bloc.state.dto?.password, 'senha123');
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit an error state when load() fails',
      setUp: () {
        when(mockStorageService.getString('email')).thenThrow(ErrorStorageException());
      },
      build: () => authBloc,
      act: (bloc) => bloc.load(),
      expect: () => [
        AuthState(status: AuthStatus.loading),
        AuthState(
          status: AuthStatus.error,
          message: StringConstants.getString(6),
        ),
      ],
      verify: (bloc) {
        verify(mockStorageService.getString('email')).called(1);
        expect(bloc.state.status, AuthStatus.error);
        expect(bloc.state.message, StringConstants.getString(6));
      },
    );
  });

  group('AuthBloc - Tests for the login() method', () {
    blocTest<AuthBloc, AuthState>(
      'should emit logging and logged states when login is successful',
      setUp: () {
        when(mockAuthService.login(any)).thenAnswer((_) async => user);
        when(mockStorageService.setString('email', 'any_email')).thenAnswer((_) async => {});
      },
      build: () => authBloc,
      act: (bloc) => bloc.login(AuthManagerDTO(email: 'teste@email.com', password: 'senha123')),
      expect: () => [
        AuthState(status: AuthStatus.logging),
        AuthState(status: AuthStatus.logged, user: user),
      ],
      verify: (bloc) {
        verify(mockAuthService.login(any)).called(1);
        verify(mockStorageService.setString('email', 'any_email')).called(1);
        expect(bloc.state.status, AuthStatus.logged);
        expect(bloc.state.user?.email, 'any_email');
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit an error state for invalid credentials',
      build: () => authBloc,
      act: (bloc) => bloc.login(AuthManagerDTO(email: '', password: '')),
      expect: () => [
        AuthState(status: AuthStatus.logging),
        AuthState(status: AuthStatus.error, message: StringConstants.getString(4)),
      ],
      verify: (bloc) {
        verifyNever(mockAuthService.login(any));
        expect(bloc.state.status, AuthStatus.error);
        expect(bloc.state.message, StringConstants.getString(4));
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit an error state when the login service fails',
      setUp: () {
        when(mockAuthService.login(any)).thenThrow(ErrorAuthSupabaseException());
      },
      build: () => authBloc,
      act: (bloc) => bloc.login(AuthManagerDTO(email: 'teste@email.com', password: 'senha123')),
      expect: () => [
        AuthState(status: AuthStatus.logging),
        AuthState(status: AuthStatus.error, message: StringConstants.getString(7)),
      ],
      verify: (bloc) {
        verify(mockAuthService.login(any)).called(1);
        expect(bloc.state.status, AuthStatus.error);
        expect(bloc.state.message, StringConstants.getString(7));
      },
    );
  });

  group('AuthBloc - Tests for the signUp() method', () {
    blocTest<AuthBloc, AuthState>(
      'should emit registering and logged states when signUp is successful',
      setUp: () {
        when(mockAuthService.signUp(any)).thenAnswer((_) async => user);
        when(mockPermissionService.createPermission(any)).thenAnswer((_) async => {});
      },
      build: () => authBloc,
      act: (bloc) => bloc.signUp(AuthManagerDTO(email: 'any_email', password: 'any_password', name: 'any_name')),
      expect: () => [
        AuthState(status: AuthStatus.registering),
        AuthState(
          status: AuthStatus.logged,
          user: user,
        ),
      ],
      verify: (bloc) {
        verify(mockAuthService.signUp(any)).called(1);
        verify(mockPermissionService.createPermission(any)).called(1);
        expect(bloc.state.status, AuthStatus.logged);
        expect(bloc.state.user?.email, user.email);
        expect(bloc.state.user?.name, user.name);
        expect(bloc.state.user?.id, user.id);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthStatus.registering, AuthStatus.error] when signUp fails',
      setUp: () {
        when(mockAuthService.signUp(any)).thenThrow(ErrorAuthSupabaseException());
      },
      build: () => authBloc,
      act: (bloc) => bloc.signUp(AuthManagerDTO(email: 'any_email', password: 'any_password', name: 'any_name')),
      expect: () => [
        AuthState(status: AuthStatus.registering),
        AuthState(status: AuthStatus.error, message: StringConstants.getString(7)),
      ],
      verify: (cubit) {
        verify(mockAuthService.signUp(any)).called(1);
        verifyNever(mockPermissionService.createPermission(any));
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthStatus.registering, AuthStatus.error] when permission creation fails',
      setUp: () {
        when(mockAuthService.signUp(any)).thenAnswer((_) async => user);
        when(mockPermissionService.createPermission(any)).thenThrow(ErrorSupabaseException());
      },
      build: () => authBloc,
      act: (cubit) => cubit.signUp(AuthManagerDTO(email: 'any_email', password: 'any_password', name: 'any_name')),
      expect: () => [
        AuthState(status: AuthStatus.registering),
        AuthState(status: AuthStatus.error, message: StringConstants.getString(5)),
      ],
      verify: (cubit) {
        verify(mockAuthService.signUp(any)).called(1);
        verify(mockPermissionService.createPermission(any)).called(1);
      },
    );
  });

  group('AuthBloc - Tests for the logout() method', () {
    blocTest<AuthBloc, AuthState>(
      'should emit loading and disconnected states when logout is successful',
      setUp: () {
        when(mockAuthService.logout()).thenAnswer((_) async => {});
      },
      build: () => authBloc,
      act: (bloc) => bloc.logout(),
      expect: () => [
        AuthState(status: AuthStatus.loading),
        AuthState(status: AuthStatus.disconnected),
      ],
      verify: (bloc) {
        verify(mockAuthService.logout()).called(1);
        expect(bloc.state.status, AuthStatus.disconnected);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'should emit [AuthStatus.loading, AuthStatus.error] when logout fails',
      setUp: () {
        when(mockAuthService.logout()).thenThrow(ErrorSupabaseException());
      },
      build: () => authBloc,
      act: (bloc) => bloc.logout(),
      expect: () => [
        AuthState(status: AuthStatus.loading),
        AuthState(status: AuthStatus.error, message: StringConstants.getString(5)),
      ],
      verify: (cubit) {
        verify(mockAuthService.logout()).called(1);
      },
    );
  });
}
