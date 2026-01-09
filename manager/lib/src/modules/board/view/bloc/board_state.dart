import '../../../../shared/export/app_export.dart';

enum BoardStatus { initial, loading, loaded, updating, updated, error }

extension BoardStatusX on BoardStatus {
  bool get isLoading => [BoardStatus.initial, BoardStatus.loading].contains(this);
  bool get isUpdating => BoardStatus.updating == this;
  bool get isLoaded => BoardStatus.loaded == this;
  bool get isUpdated => BoardStatus.updated == this;
  bool get isError => BoardStatus.error == this;
}

class BoardState extends Equatable {
  final BoardStatus status;
  final int indexJump;
  final List<TBL0003> listOfQuestionsAll;
  final List<TBL0003> listFiltered;
  final FilterQuestion filterBy;
  final String? message;

  const BoardState({
    required this.status,
    required this.indexJump,
    required this.listOfQuestionsAll,
    required this.listFiltered,
    required this.filterBy,
    this.message,
  });

  int get countAwnsered => listOfQuestionsAll.where((q) => q.isFilled).toList().length;

  factory BoardState.initial() => BoardState(
        status: BoardStatus.initial,
        filterBy: FilterQuestion.all,
        indexJump: 0,
        listFiltered: [],
        listOfQuestionsAll: [],
      );

  BoardState copyWith({
    BoardStatus? status,
    int? indexJump,
    List<TBL0003>? listOfQuestionsAll,
    List<TBL0003>? listFiltered,
    FilterQuestion? filterBy,
    String? message,
  }) {
    return BoardState(
      status: status ?? this.status,
      indexJump: indexJump ?? this.indexJump,
      filterBy: filterBy ?? this.filterBy,
      listOfQuestionsAll: listOfQuestionsAll ?? this.listOfQuestionsAll,
      listFiltered: listFiltered ?? this.listFiltered,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, indexJump, listOfQuestionsAll, listFiltered, message, filterBy];
}
