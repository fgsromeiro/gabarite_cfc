import '../../../../shared/export/app_export.dart';

enum NoteStatus { initial, loading, updating, updated, loaded, error }

extension NoteStatusX on NoteStatus {
  bool get isLoading => [NoteStatus.initial, NoteStatus.loading].contains(this);
  bool get isUpdating => [NoteStatus.updating].contains(this);
  bool get isUpdated => [NoteStatus.updated].contains(this);
  bool get isLoaded => [NoteStatus.loaded].contains(this);
  bool get isError => [NoteStatus.error].contains(this);
}

class NoteState extends Equatable {
  final NoteStatus status;
  final List<TBL0001> notes;
  final TBL0001? reference;
  final String? message;

  const NoteState({
    required this.status,
    required this.notes,
    this.message,
    this.reference,
  });

  factory NoteState.initial() => NoteState(status: NoteStatus.initial, notes: []);

  NoteState copyWith({
    NoteStatus? status,
    List<TBL0001>? notes,
    TBL0001? reference,
    String? message,
  }) {
    return NoteState(
      status: status ?? this.status,
      notes: notes ?? this.notes,
      reference: reference ?? this.reference,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, notes, reference, message];
}
