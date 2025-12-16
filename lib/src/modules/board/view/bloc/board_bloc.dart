import 'package:correcao_cfc/src/shared/export/app_export.dart';

class BoardBloc extends Cubit<BoardState> with ApplicationGlobalMixin {
  final BoardService service;
  final NoteService noteService;

  BoardBloc({
    required this.service,
    required this.noteService,
  }) : super(BoardState.initial());

  Future<void> load() async {
    try {
      emit(state.copyWith(status: BoardStatus.loading));

      final result = await service.loadAllQuestions();

      emit(
        state.copyWith(
          status: BoardStatus.loaded,
          listOfQuestionsAll: result,
          listFiltered: result,
        ),
      );
      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: BoardStatus.error,
          message: e.toString(),
        ),
      );
      return;
    }
  }

  Future<void> fillIn(TBL0003 question) async {
    try {
      emit(state.copyWith(status: BoardStatus.updating));

      await service.fillQuestion(question);

      final newListSync = await service.loadAllQuestions();

      emit(
        state.copyWith(
          status: BoardStatus.updated,
          listOfQuestionsAll: newListSync,
          listFiltered: newListSync,
          indexJump: question.index,
        ),
      );
      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: BoardStatus.error,
          message: e.toString(),
        ),
      );
      return;
    }
  }

  void search(String? value) {
    if (value == null || value.isEmpty) {
      emit(
        state.copyWith(
          listFiltered: state.listOfQuestionsAll.toList(),
          status: BoardStatus.loaded,
        ),
      );
    } else {
      emit(
        state.copyWith(
          listFiltered: filterListOfQuestionReferenceBySearch(
            state.listOfQuestionsAll.toList(),
            value,
          ),
          status: BoardStatus.loaded,
        ),
      );
    }
  }

  Future<void> filterBy(FilterQuestion filter) async {
    final question = state.listOfQuestionsAll.toList();

    if (filter == FilterQuestion.all) {
      emit(state.copyWith(listFiltered: question, status: BoardStatus.loaded));
    } else if (filter == FilterQuestion.answered) {
      emit(state.copyWith(listFiltered: question.where((q) => q.isFilled).toList(), status: BoardStatus.loaded));
    } else if (filter == FilterQuestion.notAnswered) {
      emit(state.copyWith(listFiltered: question.where((q) => !q.isFilled).toList(), status: BoardStatus.loaded));
    }
  }
}
