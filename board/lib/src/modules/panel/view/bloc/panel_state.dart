import '../../../../shared/export/app_export.dart';

enum PanelStatus { initial, loading, loaded, exported, error }

extension PanelStatusX on PanelStatus {
  bool get isLoading => [PanelStatus.initial, PanelStatus.loading].contains(this);
  bool get isLoaded => this == PanelStatus.loaded;
  bool get isError => this == PanelStatus.error;
}

class PanelState extends Equatable {
  final List<Question> listOfQuestions;
  final PanelStatus status;
  final bool showButtonsDownload;
  final String? message;

  const PanelState({
    required this.listOfQuestions,
    required this.showButtonsDownload,
    required this.status,
    this.message,
  });

  factory PanelState.initial() => PanelState(
        listOfQuestions: [],
        status: PanelStatus.initial,
        showButtonsDownload: false,
      );

  PanelState copyWith({
    List<Question>? listOfQuestions,
    PanelStatus? status,
    String? message,
    bool? showButtonsDownload,
  }) {
    return PanelState(
      listOfQuestions: listOfQuestions ?? this.listOfQuestions,
      status: status ?? this.status,
      message: message ?? this.message,
      showButtonsDownload: showButtonsDownload ?? this.showButtonsDownload,
    );
  }

  @override
  List<Object?> get props => [listOfQuestions, status, message, showButtonsDownload];
}
