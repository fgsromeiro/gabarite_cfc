import '../../../../shared/export/app_export.dart';

class VisibilityBloc extends Cubit<VisibilityState> with ApplicationGlobalMixin {
  final VisibilityService service;
  final BoardService boardService;
  final NoteService noteService;

  VisibilityBloc({
    required this.service,
    required this.boardService,
    required this.noteService,
  }) : super(VisibilityState.initial());

  Future<void> load() async {
    try {
      emit(state.copyWith(status: VisibilityStatus.loading));

      final questions = await service.loadAllQuestions();
      final notes = await noteService.findAllNotes();
      final questionsBase = await boardService.loadAllQuestions();

      emit(
        state.copyWith(
          status: VisibilityStatus.loaded,
          questions: updateListQuestionVisibility(questionsBase, questions, notes),
        ),
      );

      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: VisibilityStatus.error,
          errorMessage: e.toString(),
        ),
      );

      return;
    }
  }

  Future<void> onVisibility(QuestionVisibility question, bool value) async {
    try {
      emit(state.copyWith(status: VisibilityStatus.changing));

      final questionBase = question.questionBase.copyWith(visible: value);

      final dto = VisibilityDTO(idQuestionBase: questionBase.id, isVisible: questionBase.visible);

      await service.setVisibility(dto);

      emit(
        state.copyWith(
          status: VisibilityStatus.loaded,
          questions: setQuestionVisibility(state.questions, question.copyWith(questionBase: questionBase)),
        ),
      );

      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: VisibilityStatus.error,
          errorMessage: e.toString(),
        ),
      );

      return;
    }
  }

  Future<void> onVisibilityAll(bool value) async {
    try {
      emit(state.copyWith(status: VisibilityStatus.changing));

      final dto = VisibilityDTO(idQuestionBase: '', isVisible: value);

      await service.changeVisibilityAll(dto);

      emit(
        state.copyWith(
          status: VisibilityStatus.loaded,
          questions: setQuestionVisibilityAll(state.questions, value),
        ),
      );

      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: VisibilityStatus.error,
          errorMessage: e.toString(),
        ),
      );

      return;
    }
  }
}
