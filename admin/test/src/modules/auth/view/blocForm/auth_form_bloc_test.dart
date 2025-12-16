import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

void main() {
  group('AuthFormBloc', () {
    test('must have the correct initial state', () {
      expect(AuthFormBloc().state, AuthFormState.initial());
    });

    blocTest<AuthFormBloc, AuthFormState>(
      'must update the name in the state',
      build: () => AuthFormBloc(),
      act: (bloc) => bloc.setName('Novo Nome'),
      expect: () => [
        const AuthFormState(email: '', password: '', name: 'Novo Nome'),
      ],
    );

    blocTest<AuthFormBloc, AuthFormState>(
      'must update the email in the state',
      build: () => AuthFormBloc(),
      act: (bloc) => bloc.setEmail('novo@email.com'),
      expect: () => [
        const AuthFormState(email: 'novo@email.com', password: '', name: ''),
      ],
    );

    blocTest<AuthFormBloc, AuthFormState>(
      'must update the password in the state',
      build: () => AuthFormBloc(),
      act: (bloc) => bloc.setPassword('senha123'),
      expect: () => [
        const AuthFormState(email: '', password: 'senha123', name: ''),
      ],
    );

    blocTest<AuthFormBloc, AuthFormState>(
      'must update the fields sequentially',
      build: () => AuthFormBloc(),
      act: (bloc) async {
        await bloc.setName('Test User');
        await bloc.setEmail('test@email.com');
        await bloc.setPassword('password123');
      },
      expect: () => [
        const AuthFormState(email: '', password: '', name: 'Test User'),
        const AuthFormState(email: 'test@email.com', password: '', name: 'Test User'),
        const AuthFormState(email: 'test@email.com', password: 'password123', name: 'Test User'),
      ],
    );
  });
}
