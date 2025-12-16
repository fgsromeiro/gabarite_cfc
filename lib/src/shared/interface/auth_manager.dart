abstract class AuthManager<T> {
  Future<Map<String, dynamic>> signIn({required T dto});
  Future<Map<String, dynamic>> signUp({required T dto});
  Map<String, dynamic> currentUser();
  Future<void> logOut();
}
