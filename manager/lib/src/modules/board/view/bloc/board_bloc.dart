import 'package:gabarite_cfc/src/shared/export/app_export.dart';

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
      filterBy(state.filterBy);
    } else {
      emit(
        state.copyWith(
          listFiltered: filterListOfQuestionReferenceBySearch(
            listByFilter(state.listOfQuestionsAll, state.filterBy),
            value,
          ),
          status: BoardStatus.loaded,
        ),
      );
    }
  }

  Future<void> filterBy(FilterQuestion filter) async {
    final questions = state.listOfQuestionsAll.toList();

    emit(
      state.copyWith(
        listFiltered: listByFilter(questions, filter),
        status: BoardStatus.loaded,
        filterBy: filter,
      ),
    );
  }
}
