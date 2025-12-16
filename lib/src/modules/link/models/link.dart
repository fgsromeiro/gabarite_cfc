import '../../../shared/export/app_export.dart';

class Link extends Equatable {
  final TBL0003 questionBase;
  final Map<int, TBL0003> mapQuestionsLinked;

  const Link({
    required this.questionBase,
    required this.mapQuestionsLinked,
  });

  bool get isLinked =>
      mapQuestionsLinked[1]!.id.isNotEmpty &&
      mapQuestionsLinked[2]!.id.isNotEmpty &&
      mapQuestionsLinked[3]!.id.isNotEmpty &&
      mapQuestionsLinked[4]!.id.isNotEmpty;

  Link copyWith({
    TBL0003? questionBase,
    Map<int, TBL0003>? mapQuestionsLinked,
  }) {
    return Link(
      questionBase: questionBase ?? this.questionBase,
      mapQuestionsLinked: mapQuestionsLinked ?? this.mapQuestionsLinked,
    );
  }

  @override
  List<Object> get props => [questionBase, mapQuestionsLinked];
}
