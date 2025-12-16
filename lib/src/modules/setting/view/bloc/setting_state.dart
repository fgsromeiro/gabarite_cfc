import 'package:correcao_cfc/src/shared/export/app_export.dart';

enum SettingStatus { initial, loading, updating, updated, success, error }

extension SettingStatusX on SettingStatus {
  bool get isLoading => [SettingStatus.initial, SettingStatus.loading].contains(this);
  bool get isSuccess => SettingStatus.success == this;
  bool get isUpdating => SettingStatus.updating == this;
  bool get isUpdated => SettingStatus.updated == this;
  bool get isError => SettingStatus.error == this;
}

class SettingState extends Equatable {
  final SettingStatus status;
  final List<TBL0004> users;
  final TBL0005? display;
  final String? message;

  const SettingState({
    required this.status,
    required this.users,
    this.display,
    this.message,
  });

  factory SettingState.initial() => SettingState(status: SettingStatus.initial, users: []);

  SettingState copyWith({
    SettingStatus? status,
    List<TBL0004>? users,
    TBL0005? display,
    String? message,
  }) {
    return SettingState(
      status: status ?? this.status,
      users: users ?? this.users,
      display: display ?? this.display,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, users, display, message];
}
