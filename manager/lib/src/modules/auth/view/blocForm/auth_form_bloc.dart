import '../../../../shared/export/app_export.dart';

class AuthFormBloc extends Cubit<AuthFormState> {
  AuthFormBloc() : super(AuthFormState.initial());

  Future<void> setName(String? name) async {
    emit(state.copyWith(name: name));
  }

  Future<void> setEmail(String? email) async {
    emit(state.copyWith(email: email));
  }

  Future<void> setPassword(String? password) async {
    emit(state.copyWith(password: password));
  }
}
