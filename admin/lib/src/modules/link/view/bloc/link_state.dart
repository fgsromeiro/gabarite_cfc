import '../../../../shared/export/app_export.dart';

enum LinkStatus { initial, loading, loaded, finding, finded, linking, linked, error }

enum LinkFilter { none, linked, unlinked }

extension LinkStatusX on LinkStatus {
  bool get isLoading => [
        LinkStatus.initial,
        LinkStatus.loading,
        LinkStatus.finding,
        LinkStatus.linking,
      ].contains(this);

  bool get isLoaded => [
        LinkStatus.loaded,
        LinkStatus.finded,
        LinkStatus.linked,
      ].contains(this);
}

extension LinkFilterX on LinkFilter {
  bool get isFiltered => [
        LinkFilter.linked,
        LinkFilter.unlinked,
      ].contains(this);
}

class LinkState extends Equatable {
  final LinkStatus status;
  final LinkFilter filter;
  final List<TBL0002> questions;
  final List<TBL0002> questionsFiltered;
  final List<TBL0003> questionsRefs;
  final List<String> listOfIdQuestionsLinked;
  final int indexJump;
  final TBL0001? noteSelected;
  final String? message;

  const LinkState({
    required this.status,
    required this.filter,
    required this.questions,
    required this.questionsFiltered,
    required this.questionsRefs,
    required this.listOfIdQuestionsLinked,
    required this.indexJump,
    this.message,
    this.noteSelected,
  });

  bool get isEmpty => questionsFiltered.isEmpty;

  bool get isFilteredAndEmpty => filter.isFiltered && questionsFiltered.isEmpty;

  int get countLinked => questions.where((q) => q.idQuestionBase.isNotEmpty).toList().length;

  factory LinkState.initial() => LinkState(
        status: LinkStatus.initial,
        filter: LinkFilter.none,
        questions: [],
        questionsFiltered: [],
        questionsRefs: [],
        listOfIdQuestionsLinked: [],
        indexJump: 0,
      );

  LinkState copyWith({
    LinkStatus? status,
    LinkFilter? filter,
    List<TBL0002>? questions,
    List<TBL0002>? questionsFiltered,
    List<TBL0003>? questionsRefs,
    List<String>? listOfIdQuestionsLinked,
    int? indexJump,
    TBL0001? noteSelected,
    String? message,
  }) {
    return LinkState(
      status: status ?? this.status,
      filter: filter ?? this.filter,
      questions: questions ?? this.questions,
      questionsFiltered: questionsFiltered ?? this.questionsFiltered,
      questionsRefs: questionsRefs ?? this.questionsRefs,
      listOfIdQuestionsLinked: listOfIdQuestionsLinked ?? this.listOfIdQuestionsLinked,
      indexJump: indexJump ?? this.indexJump,
      noteSelected: noteSelected ?? this.noteSelected,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props {
    return [
      status,
      filter,
      questions,
      questionsFiltered,
      questionsRefs,
      listOfIdQuestionsLinked,
      indexJump,
      noteSelected,
      message,
    ];
  }
}
