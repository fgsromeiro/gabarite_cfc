import '../../../../shared/export/app_export.dart';

class AuthFormState extends Equatable {
  final String email;
  final String password;
  final String name;

  const AuthFormState({
    required this.email,
    required this.password,
    required this.name,
  });

  factory AuthFormState.initial() => AuthFormState(
        email: '',
        password: '',
        name: '',
      );

  AuthFormState copyWith({
    String? email,
    String? password,
    String? name,
  }) {
    return AuthFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      name: name ?? this.name,
    );
  }

  @override
  List<Object?> get props => [email, password, name];
}
