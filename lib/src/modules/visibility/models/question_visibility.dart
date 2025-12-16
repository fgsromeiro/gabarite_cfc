import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class QuestionVisibility extends Equatable {
  final TBL0003 questionBase;
  final int? indexTypeOne;
  final int? indexTypeTwo;
  final int? indexTypeThree;
  final int? indexTypeFour;

  const QuestionVisibility({
    required this.questionBase,
    this.indexTypeOne,
    this.indexTypeTwo,
    this.indexTypeThree,
    this.indexTypeFour,
  });

  String get title => questionBase.title;
  bool get isVisible => questionBase.visible;

  QuestionVisibility copyWith({
    TBL0003? questionBase,
    int? indexTypeOne,
    int? indexTypeTwo,
    int? indexTypeThree,
    int? indexTypeFour,
  }) {
    return QuestionVisibility(
      questionBase: questionBase ?? this.questionBase,
      indexTypeOne: indexTypeOne ?? this.indexTypeOne,
      indexTypeTwo: indexTypeTwo ?? this.indexTypeTwo,
      indexTypeThree: indexTypeThree ?? this.indexTypeThree,
      indexTypeFour: indexTypeFour ?? this.indexTypeFour,
    );
  }

  @override
  List<Object?> get props => [questionBase, indexTypeOne, indexTypeTwo, indexTypeThree, indexTypeFour];
}
