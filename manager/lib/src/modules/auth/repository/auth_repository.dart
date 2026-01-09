import '../../../shared/export/app_export.dart';

abstract class AuthRepository {
  Future<UserModel> login(AuthManagerDTO dto);
  Future<void> logout();
  Future<UserModel> signUp(AuthManagerDTO dto);
  Future<UserModel> currentUser();
}

class AuthRepositoryImpl implements AuthRepository {
  final AuthManager authManager;
  final NetworkVerifier networkVerifier;

  AuthRepositoryImpl({
    required this.authManager,
    required this.networkVerifier,
  });

  @override
  Future<UserModel> login(AuthManagerDTO dto) async {
    try {
      await networkVerifier.verifyConnection();

      final result = await authManager.signIn(dto: dto);

      return UserModel.fromMap(result);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await networkVerifier.verifyConnection();

      return await authManager.logOut();
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> currentUser() async {
    try {
      await networkVerifier.verifyConnection();

      final result = authManager.currentUser();

      return UserModel.fromMap(result);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<UserModel> signUp(AuthManagerDTO dto) async {
    try {
      await networkVerifier.verifyConnection();

      final newUser = await authManager.signUp(dto: dto);

      return UserModel.fromMap(newUser);
    } catch (e) {
      rethrow;
    }
  }
}
