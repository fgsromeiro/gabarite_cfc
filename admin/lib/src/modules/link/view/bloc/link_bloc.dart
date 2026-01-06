import '../../../../shared/export/app_export.dart';

class LinkBloc extends Cubit<LinkState> with ApplicationGlobalMixin {
  final LinkService linkService;
  final BoardService boardService;

  LinkBloc({
    required this.linkService,
    required this.boardService,
  }) : super(LinkState.initial());

  Future<void> load() async {
    try {
      emit(state.copyWith(status: LinkStatus.loading));

      final questions = await boardService.loadAllQuestions();

      emit(
        state.copyWith(
          status: LinkStatus.loaded,
          questionsRefs: questions,
        ),
      );

      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: LinkStatus.error,
          message: e.toString(),
        ),
      );

      return;
    }
  }

  Future<void> loadQuestionsByNote(TBL0001 note) async {
    try {
      if (note.id.isEmpty) return load();

      emit(state.copyWith(status: LinkStatus.finding));

      final questions = await linkService.findQuestionsByNote(note.id);

      emit(
        state.copyWith(
          status: LinkStatus.finded,
          questions: questions,
          questionsFiltered: questions,
          noteSelected: note,
          listOfIdQuestionsLinked: verifyListIfContainsLink(questions),
          filter: LinkFilter.none,
        ),
      );

      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: LinkStatus.error,
          message: e.toString(),
        ),
      );

      return;
    }
  }

  void search(String? value) {
    if (value == null || value.isEmpty) {
      emit(state.copyWith(questionsFiltered: state.questions.toList()));
    } else {
      emit(
        state.copyWith(
          questionsFiltered: filterListByIndex(state.questions.toList(), value),
        ),
      );
    }
  }

  Future<void> link(TBL0003 qBase, String idQuestion, int index) async {
    try {
      emit(state.copyWith(status: LinkStatus.linking));

      final dto = FunctionLinkDTO(
        id: idQuestion,
        idQuestionbase: qBase.id,
        enunciated: qBase.enunciated,
        alternative: qBase.alternative,
        textAlternative: qBase.textAlternative,
        visible: qBase.visible,
      );

      await linkService.link(dto);
      final listSync = await linkService.findQuestionsByNote(state.noteSelected!.id);

      emit(
        state.copyWith(
          status: LinkStatus.linked,
          indexJump: index++,
          questions: listSync,
          questionsFiltered: listSync,
          listOfIdQuestionsLinked: verifyListIfContainsLink(listSync),
          message: 'Questão vinculada com sucesso',
        ),
      );

      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: LinkStatus.error,
          message: e.toString(),
        ),
      );

      return;
    }
  }

  Future<void> removeLink(
    TBL0002 question,
  ) async {
    try {
      emit(
        state.copyWith(
          status: LinkStatus.linking,
        ),
      );

      final dto = FunctionLinkDTO(
        id: question.id,
      );

      await linkService.removeLink(dto);
      final listSync = await linkService.findQuestionsByNote(state.noteSelected!.id);

      emit(
        state.copyWith(
          status: LinkStatus.linked,
          questions: listSync,
          questionsFiltered: listSync,
          indexJump: question.index,
          listOfIdQuestionsLinked: verifyListIfContainsLink(listSync),
          message: 'Questão desvinculada com sucesso',
        ),
      );

      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: LinkStatus.error,
          message: e.toString(),
        ),
      );

      return;
    }
  }
}
