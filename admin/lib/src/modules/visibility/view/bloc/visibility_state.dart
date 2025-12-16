import 'package:gabarite_cfc/src/shared/export/app_export.dart';

enum VisibilityStatus { initial, loading, loaded, changing, error }

extension VisibilityStatusX on VisibilityStatus {
  bool get isLoading => [VisibilityStatus.initial, VisibilityStatus.loading].contains(this);
  bool get isChanging => [VisibilityStatus.changing].contains(this);
  bool get isLoaded => [VisibilityStatus.loaded].contains(this);
  bool get isError => [VisibilityStatus.error].contains(this);
}

class VisibilityState extends Equatable {
  final VisibilityStatus status;
  final List<QuestionVisibility> questions;
  final String? errorMessage;

  const VisibilityState({
    required this.status,
    required this.questions,
    this.errorMessage,
  });

  factory VisibilityState.initial() {
    return const VisibilityState(
      status: VisibilityStatus.initial,
      questions: [],
    );
  }

  bool get isVisilityAll => questions.where((q) => q.isVisible).length == 50;

  VisibilityState copyWith({
    VisibilityStatus? status,
    List<QuestionVisibility>? questions,
    String? errorMessage,
  }) {
    return VisibilityState(
      status: status ?? this.status,
      questions: questions ?? this.questions,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, questions, errorMessage];
}
