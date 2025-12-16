import '../../../../shared/export/app_export.dart';

enum MenuStatus { initial, loading, loaded, error }

extension MenuStatusX on MenuStatus {
  bool get isLoading => [MenuStatus.initial, MenuStatus.loading].contains(this);
  bool get isLoaded => this == MenuStatus.loaded;
  bool get isError => this == MenuStatus.error;
}

class MenuState extends Equatable {
  final MenuStatus status;
  final String? message;
  final int currentIndex;
  final UserModel user;
  final TBL0004 permission;

  const MenuState({
    required this.status,
    this.message,
    required this.currentIndex,
    required this.user,
    required this.permission,
  });

  factory MenuState.initial() => MenuState(
        status: MenuStatus.initial,
        currentIndex: 0,
        user: UserModel(id: '', email: '', name: ''),
        permission: TBL0004.instance(),
      );

  MenuState copyWith({
    MenuStatus? status,
    String? message,
    int? currentIndex,
    UserModel? user,
    TBL0004? permission,
  }) {
    return MenuState(
      status: status ?? this.status,
      message: message ?? this.message,
      currentIndex: currentIndex ?? this.currentIndex,
      user: user ?? this.user,
      permission: permission ?? this.permission,
    );
  }

  @override
  List<Object?> get props => [status, message, currentIndex, user, permission];
}
