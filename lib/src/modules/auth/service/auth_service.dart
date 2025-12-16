import '../../../shared/export/app_export.dart';

abstract class AuthService {
  Future<UserModel> login(AuthManagerDTO dto);
  Future<void> logout();
  Future<UserModel> signUp(AuthManagerDTO dto);
  Future<UserModel> currentUser();
}

class AuthServiceImpl implements AuthService {
  final AuthRepository repository;

  AuthServiceImpl({
    required this.repository,
  });

  @override
  Future<UserModel> login(AuthManagerDTO dto) async {
    return await repository.login(dto);
  }

  @override
  Future<void> logout() async {
    return await repository.logout();
  }

  @override
  Future<UserModel> currentUser() async {
    return await repository.currentUser();
  }

  @override
  Future<UserModel> signUp(AuthManagerDTO dto) async {
    return await repository.signUp(dto);
  }
}
