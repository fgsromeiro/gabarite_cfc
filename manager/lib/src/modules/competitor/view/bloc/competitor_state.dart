import '../../../../shared/export/app_export.dart';

enum CompetitorStatus { initial, loading, changing, loaded, error }

extension CompetitorStatusX on CompetitorStatus {
  bool get isLoading => [CompetitorStatus.initial, CompetitorStatus.loading].contains(this);
  bool get isLoaded => [CompetitorStatus.loaded].contains(this);
  bool get isError => [CompetitorStatus.error].contains(this);
  bool get isChanging => [CompetitorStatus.changing].contains(this);
}

class CompetitorState extends Equatable {
  final CompetitorStatus status;
  final List<TBL0006> competitors;
  final String idNote;
  final String? message;

  const CompetitorState({
    required this.status,
    required this.competitors,
    required this.idNote,
    this.message,
  });

  factory CompetitorState.initial() => CompetitorState(
        status: CompetitorStatus.initial,
        competitors: [],
        idNote: '',
      );

  CompetitorState copyWith({
    CompetitorStatus? status,
    List<TBL0006>? competitors,
    String? idNote,
    String? message,
  }) {
    return CompetitorState(
      status: status ?? this.status,
      competitors: competitors ?? this.competitors,
      idNote: idNote ?? this.idNote,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, competitors, idNote, message];
}
