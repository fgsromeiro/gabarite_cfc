import '../export/app_export.dart';

mixin ApplicationGlobalMixin {
  TBL0001? getNoteReference(List<TBL0001> listOfNote) {
    if (listOfNote.any(
      (n) => n.isReference,
    )) {
      return listOfNote.firstWhere(
        (n) => n.isReference,
      );
    }

    return null;
  }

  List<TBL0002> updateQuestionInList(
    List<TBL0002> questions,
    FunctionLinkDTO dto,
  ) {
    return questions.map((q) {
      if (q.id == dto.id) {
        return q.copyWith(
          alternative: dto.alternative,
          enunciated: dto.enunciated,
          idQuestionBase: dto.idQuestionbase,
          textAlternative: dto.alternative,
        );
      }
      return q;
    }).toList();
  }

  List<String> verifyListIfContainsLink(List<TBL0002> listOfQuestions) {
    return listOfQuestions.where((q) => q.idQuestionBase.isNotEmpty).map((q) => q.idQuestionBase).toList();
  }

  List<TBL0002> filterListByIndex(List<TBL0002> questions, String value) {
    final list = questions.where(
      (e) {
        return e.index == int.parse(value);
      },
    ).toList();

    return list;
  }

  Color? mapperColorAlternative(String value) {
    if (value == 'ANULADO' ||
        value == 'RECURSO' ||
        value == 'A/R' ||
        value == 'B/R' ||
        value == 'C/R' ||
        value == 'D/R') {
      return const Color.fromARGB(255, 208, 52, 52);
    }
    return AppColors.white;
  }

  String mapperTextAlternative(String value) {
    if (value.isEmpty) return '';

    if (value.length > 3) return value[0];

    return value;
  }

  TBL0003? getQustionBaseReference({required String id, required List<TBL0003> listOfQuestionsBase}) {
    if (listOfQuestionsBase.any((q) => q.id == id)) {
      return listOfQuestionsBase.firstWhere(
        (q) => q.id == id,
      );
    }

    return null;
  }

  List<TBL0006> updateListCompetitors(List<TBL0006> competitors, List<TBL0006> competitorsUpdated) {
    var result = competitors;

    for (var competitor in competitorsUpdated) {
      result = result.map((c) {
        if (c.id == competitor.id) {
          return competitor;
        }
        return c;
      }).toList();
    }
    return result;
  }

  List<QuestionVisibility> updateListQuestionVisibility(
    List<TBL0003> questionsBase,
    List<TBL0002> questions,
    List<TBL0001> notes,
  ) {
    List<QuestionVisibility> result = [];

    for (var question in questionsBase) {
      final questionTypeOne = questions.firstWhere((q) => q.idQuestionBase == question.id && q.idNote == notes[0].id,
          orElse: () => TBL0002.instance());
      final questionTypeTwo = questions.firstWhere((q) => q.idQuestionBase == question.id && q.idNote == notes[1].id,
          orElse: () => TBL0002.instance());
      final questionTypeThree = questions.firstWhere((q) => q.idQuestionBase == question.id && q.idNote == notes[2].id,
          orElse: () => TBL0002.instance());
      final questionTypeFour = questions.firstWhere((q) => q.idQuestionBase == question.id && q.idNote == notes[3].id,
          orElse: () => TBL0002.instance());

      result.add(QuestionVisibility(
        questionBase: question,
        indexTypeOne: questionTypeOne.isEmpty ? null : questionTypeOne.index,
        indexTypeTwo: questionTypeTwo.isEmpty ? null : questionTypeTwo.index,
        indexTypeThree: questionTypeThree.isEmpty ? null : questionTypeThree.index,
        indexTypeFour: questionTypeFour.isEmpty ? null : questionTypeFour.index,
      ));
    }
    return result..sort((a, b) => a.questionBase.index.compareTo(b.questionBase.index));
  }

  List<QuestionVisibility> setQuestionVisibility(
    List<QuestionVisibility> questions,
    QuestionVisibility questionChanged,
  ) {
    final result = questions.map(
      (q) {
        if (q.questionBase.id == questionChanged.questionBase.id) {
          return questionChanged;
        }
        return q;
      },
    ).toList();

    return result;
  }

  List<QuestionVisibility> setQuestionVisibilityAll(
    List<QuestionVisibility> questions,
    bool visibility,
  ) {
    final result = questions.map(
      (q) {
        final questionCopied = q.questionBase.copyWith(visible: visibility);

        return q.copyWith(questionBase: questionCopied);
      },
    ).toList();

    return result;
  }

  List<TBL0003> filterListOfQuestionReferenceBySearch(
    List<TBL0003> questions,
    String value,
  ) {
    final list = questions.where((e) => e.index == int.parse(value)).toList();

    return list;
  }
}
