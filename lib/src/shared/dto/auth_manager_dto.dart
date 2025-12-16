import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class AuthManagerDTO extends Equatable {
  final String email;
  final String password;
  final String? name;

  const AuthManagerDTO({
    required this.email,
    required this.password,
    this.name,
  });

  bool get isValid => email.isNotEmpty && password.isNotEmpty;

  @override
  List<Object?> get props => [email, password, name];
}
