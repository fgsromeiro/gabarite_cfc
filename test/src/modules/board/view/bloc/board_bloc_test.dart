import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixture_reader.dart';
import '../../../../../mocks/mocks.mocks.dart';

void main() {
  late MockBoardService mockBoardService;
  late MockNoteService mockNoteService;
  late BoardBloc boardBloc;
  late List<TBL0003> listOfQuestions;
  late TBL0003 question;
  late Map<String, dynamic> dataMap;

  setUp(() {
    dataMap = fixture('list_of_questions_reference.json');

    question = TBL0003.instance();
    mockBoardService = MockBoardService();
    mockNoteService = MockNoteService();
    boardBloc = BoardBloc(service: mockBoardService, noteService: mockNoteService);
    listOfQuestions = (dataMap['questions'] as List).map((q) => TBL0003.fromMap(q as Map<String, dynamic>)).toList();
  });

  tearDown(() {
    boardBloc.close();
    reset(mockBoardService);
    reset(mockNoteService);
  });

  group('BoardBloc - Tests for the load() method', () {
    blocTest<BoardBloc, BoardState>(
      'should issue a new state with the list of questions by successfully carrying',
      setUp: () {
        when(mockBoardService.loadAllQuestions()).thenAnswer((_) async => listOfQuestions);
      },
      build: () => boardBloc,
      act: (bloc) => bloc.load(),
      expect: () => [
        BoardState.initial().copyWith(status: BoardStatus.loading),
        BoardState.initial().copyWith(
          status: BoardStatus.loaded,
          listOfQuestionsAll: listOfQuestions,
          listFiltered: listOfQuestions,
        ),
      ],
      verify: (bloc) {
        verify(mockBoardService.loadAllQuestions()).called(1);
        expect(bloc.state.status, BoardStatus.loaded);
        expect(bloc.state.listOfQuestionsAll, listOfQuestions);
        expect(bloc.state.listFiltered, listOfQuestions);
      },
    );

    blocTest<BoardBloc, BoardState>(
      'should emit an error state when load() fails',
      setUp: () {
        when(mockBoardService.loadAllQuestions()).thenThrow(ErrorSupabaseException());
      },
      build: () => boardBloc,
      act: (bloc) => bloc.load(),
      expect: () => [
        BoardState.initial().copyWith(status: BoardStatus.loading),
        BoardState.initial().copyWith(
          status: BoardStatus.error,
          message: ErrorSupabaseException().toString(),
        ),
      ],
      verify: (bloc) {
        verify(mockBoardService.loadAllQuestions()).called(1);
        expect(bloc.state.status, BoardStatus.error);
        expect(bloc.state.message, ErrorSupabaseException().toString());
      },
    );
  });
  group('BoardBloc - Tests for the fillIn() method', () {
    blocTest<BoardBloc, BoardState>(
      'should issue a new state with the list of questions by successfully carrying',
      setUp: () {
        when(mockBoardService.fillQuestion(any)).thenAnswer((_) async => Future.value());
        when(mockBoardService.loadAllQuestions()).thenAnswer((_) async => listOfQuestions);
      },
      build: () => boardBloc,
      act: (bloc) => bloc.fillIn(question),
      expect: () => [
        BoardState.initial().copyWith(status: BoardStatus.updating),
        BoardState.initial().copyWith(
          status: BoardStatus.updated,
          listOfQuestionsAll: listOfQuestions,
          listFiltered: listOfQuestions,
          indexJump: question.index,
        ),
      ],
      verify: (bloc) {
        verify(mockBoardService.fillQuestion(any)).called(1);
        expect(bloc.state.status, BoardStatus.updated);
        expect(bloc.state.listOfQuestionsAll, listOfQuestions);
        expect(bloc.state.listFiltered, listOfQuestions);
      },
    );

    blocTest<BoardBloc, BoardState>(
      'should emit an error state when fillIn() fails',
      setUp: () {
        when(mockBoardService.fillQuestion(any)).thenThrow(ErrorSupabaseException());
      },
      build: () => boardBloc,
      act: (bloc) => bloc.fillIn(question),
      expect: () => [
        BoardState.initial().copyWith(status: BoardStatus.updating),
        BoardState.initial().copyWith(
          status: BoardStatus.error,
          message: ErrorSupabaseException().toString(),
        ),
      ],
      verify: (bloc) {
        verify(mockBoardService.fillQuestion(any)).called(1);
        expect(bloc.state.status, BoardStatus.error);
        expect(bloc.state.message, ErrorSupabaseException().toString());
      },
    );
  });

  group('BoardBloc - Tests for the search() method', () {
    blocTest<BoardBloc, BoardState>(
      'when Value is null must issue full list',
      seed: () => BoardState.initial().copyWith(
        listOfQuestionsAll: listOfQuestions,
        listFiltered: listOfQuestions,
      ),
      build: () => boardBloc,
      act: (bloc) => bloc.search(null),
      expect: () => [
        boardBloc.state.copyWith(
          listFiltered: listOfQuestions,
          status: BoardStatus.loaded,
        ),
      ],
    );

    blocTest<BoardBloc, BoardState>(
      'when Value is empty must issue full list',
      seed: () => BoardState.initial().copyWith(
        listOfQuestionsAll: listOfQuestions,
        listFiltered: listOfQuestions,
      ),
      build: () => boardBloc,
      act: (bloc) => bloc.search(''),
      expect: () => [
        boardBloc.state.copyWith(
          listFiltered: listOfQuestions,
          status: BoardStatus.loaded,
        ),
      ],
    );

    blocTest<BoardBloc, BoardState>(
      'when Value contains term must issue filtered list',
      seed: () => BoardState.initial().copyWith(
        listOfQuestionsAll: listOfQuestions,
        listFiltered: listOfQuestions,
      ),
      build: () => boardBloc,
      act: (bloc) => bloc.search('1'),
      expect: () => [
        boardBloc.state.copyWith(
          listFiltered: listOfQuestions.where((e) => e.index == int.parse('1')).toList(),
          status: BoardStatus.loaded,
        ),
      ],
    );

    blocTest<BoardBloc, BoardState>(
      'when Value does not match anything must issue empty list',
      seed: () => BoardState.initial().copyWith(
        listOfQuestionsAll: listOfQuestions,
        listFiltered: listOfQuestions,
      ),
      build: () => boardBloc,
      act: (bloc) => bloc.search('50'),
      expect: () => [
        boardBloc.state.copyWith(listFiltered: [], status: BoardStatus.loaded),
      ],
    );
  });
  group('BoardBloc - Tests for the filterBy() method', () {
    blocTest<BoardBloc, BoardState>(
      'must issue the full list (all)',
      seed: () => BoardState.initial().copyWith(
        listOfQuestionsAll: listOfQuestions,
        listFiltered: listOfQuestions,
      ),
      build: () => boardBloc,
      act: (bloc) => bloc.filterBy(FilterQuestion.all),
      expect: () => [
        boardBloc.state.copyWith(
          listFiltered: listOfQuestions,
          status: BoardStatus.loaded,
        ),
      ],
    );

    blocTest<BoardBloc, BoardState>(
      'must only issue the questions answered (answered)',
      seed: () => BoardState.initial().copyWith(
        listOfQuestionsAll: listOfQuestions,
        listFiltered: listOfQuestions,
      ),
      build: () => boardBloc,
      act: (bloc) => bloc.filterBy(FilterQuestion.answered),
      expect: () => [
        boardBloc.state.copyWith(
          listFiltered: listOfQuestions.where((q) => q.isFilled).toList(),
          status: BoardStatus.loaded,
        ),
      ],
    );

    blocTest<BoardBloc, BoardState>(
      'must issue only the unanswered questions (notAnswered)',
      seed: () => BoardState.initial().copyWith(
        listOfQuestionsAll: listOfQuestions,
        listFiltered: listOfQuestions,
      ),
      build: () => boardBloc,
      act: (bloc) => bloc.filterBy(FilterQuestion.notAnswered),
      expect: () => [
        boardBloc.state.copyWith(
          listFiltered: listOfQuestions.where((q) => !q.isFilled).toList(),
          status: BoardStatus.loaded,
        ),
      ],
    );
  });
}
