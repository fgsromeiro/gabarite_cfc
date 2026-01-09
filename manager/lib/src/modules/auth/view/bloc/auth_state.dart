import '../../../../shared/export/app_export.dart';

enum AuthStatus { initial, loading, logging, registering, loaded, logged, disconnected, error }

extension AuthStatusX on AuthStatus {
  bool get isLoading => [AuthStatus.initial, AuthStatus.loading].contains(this);
  bool get isLoaded => this == AuthStatus.loaded;
  bool get isLogging => this == AuthStatus.logging;
  bool get isRegistering => this == AuthStatus.registering;
  bool get isLogged => this == AuthStatus.logged;
  bool get isError => this == AuthStatus.error;
  bool get isDisconnected => this == AuthStatus.disconnected;
}

class AuthState extends Equatable {
  final AuthStatus status;
  final AuthManagerDTO? dto;
  final UserModel? user;
  final String? message;
  

  const AuthState({
    required this.status,
    this.dto,
    this.user,
    this.message,
  });

  factory AuthState.initial() => AuthState(status: AuthStatus.initial);

  AuthState copyWith({
    AuthStatus? status,
    AuthManagerDTO? dto,
    UserModel? user,
    String? message,
  }) {
    return AuthState(
      status: status ?? this.status,
      dto: dto ?? this.dto,
      user: user ?? this.user,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, dto, user, message];
}
