import 'package:gabarite_cfc/src/shared/export/app_export.dart';

enum SplashStatus { initial, loading, authenticated, unauthenticated }

extension SplashStatusExtension on SplashStatus {
  bool get isLoading => [SplashStatus.initial, SplashStatus.loading].contains(this);
  bool get isAuthenticated => this == SplashStatus.authenticated;
  bool get isUnauthenticated => this == SplashStatus.unauthenticated;
}

class SplashState extends Equatable {
  final String? message;
  final SplashStatus status;

  const SplashState({
    this.message,
    required this.status,
  });

  factory SplashState.initial() => const SplashState(status: SplashStatus.initial);

  SplashState copyWith({
    String? message,
    SplashStatus? status,
  }) {
    return SplashState(
      message: message ?? this.message,
      status: status ?? this.status,
    );
  }

  @override
  List<Object?> get props => [status, message];
}
