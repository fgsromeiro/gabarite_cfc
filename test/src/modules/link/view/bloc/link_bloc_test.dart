import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixture_reader.dart';
import '../../../../../mocks/mocks.mocks.dart';

void main() {
  late MockLinkService mockLinkService;
  late MockBoardService mockBoardService;
  late LinkBloc linkBloc;

  setUp(() {
    mockLinkService = MockLinkService();
    mockBoardService = MockBoardService();
    linkBloc = LinkBloc(linkService: mockLinkService, boardService: mockBoardService);
  });

  tearDown(() {
    linkBloc.close();
    reset(mockLinkService);
    reset(mockBoardService);
  });

  group('LinkBloc - Tests for the load() method', () {
    blocTest<LinkBloc, LinkState>(
      'should issue a new state with the list of questions by successfully carrying',
      setUp: () {
        when(mockBoardService.loadAllQuestions()).thenAnswer((_) async => List.empty());
      },
      build: () => linkBloc,
      act: (bloc) => bloc.load(),
      expect: () => [
        LinkState.initial().copyWith(status: LinkStatus.loading),
        LinkState.initial().copyWith(status: LinkStatus.loaded, questionsRefs: List.empty()),
      ],
      verify: (bloc) {
        verify(mockBoardService.loadAllQuestions()).called(1);
        expect(bloc.state.status, LinkStatus.loaded);
        expect(bloc.state.questionsRefs, List.empty());
      },
    );

    blocTest<LinkBloc, LinkState>(
      'should emit an error state when load() fails',
      setUp: () {
        when(mockBoardService.loadAllQuestions()).thenThrow(ErrorSupabaseException());
      },
      build: () => linkBloc,
      act: (bloc) => bloc.load(),
      expect: () => [
        LinkState.initial().copyWith(status: LinkStatus.loading),
        LinkState.initial().copyWith(status: LinkStatus.error, message: ErrorSupabaseException().toString()),
      ],
      verify: (bloc) {
        verify(mockBoardService.loadAllQuestions()).called(1);
        expect(bloc.state.status, LinkStatus.error);
        expect(bloc.state.message, ErrorSupabaseException().toString());
      },
    );
  });
  group('LinkBloc - Tests for the loadQuestionsByNote() method', () {
    blocTest<LinkBloc, LinkState>(
      'should search and issue the status with the list of questions linked to the notebook successfully',
      setUp: () {
        when(mockLinkService.findQuestionsByNote(any)).thenAnswer((_) async => List.empty());
      },
      build: () => linkBloc,
      act: (bloc) => bloc.loadQuestionsByNote(TBL0001.instance()),
      expect: () => [
        LinkState.initial().copyWith(status: LinkStatus.finding),
        LinkState.initial().copyWith(
          status: LinkStatus.finded,
          questions: List.empty(),
          questionsFiltered: List.empty(),
          noteSelected: TBL0001.instance(),
          listOfIdQuestionsLinked: List.empty(),
          filter: LinkFilter.none,
        ),
      ],
      verify: (bloc) {
        verify(mockLinkService.findQuestionsByNote(any)).called(1);
        expect(bloc.state.status, LinkStatus.finded);
        expect(bloc.state.questions, List.empty());
      },
    );

    blocTest<LinkBloc, LinkState>(
      'should emit an error state when load() fails',
      setUp: () {
        when(mockLinkService.findQuestionsByNote(any)).thenThrow(ErrorSupabaseException());
      },
      build: () => linkBloc,
      act: (bloc) => bloc.loadQuestionsByNote(TBL0001.instance()),
      expect: () => [
        LinkState.initial().copyWith(status: LinkStatus.finding),
        LinkState.initial().copyWith(status: LinkStatus.error, message: ErrorSupabaseException().toString()),
      ],
      verify: (bloc) {
        verify(mockLinkService.findQuestionsByNote(any)).called(1);
        expect(bloc.state.status, LinkStatus.error);
        expect(bloc.state.message, ErrorSupabaseException().toString());
      },
    );
  });

  group('LinkBloc - Tests for the search() method', () {
    late List<TBL0002> listOfQuestions;
    late Map<String, dynamic> dataMap;

    setUp(() {
      dataMap = fixture('list_of_questions_by_note.json');
      listOfQuestions = (dataMap['questions'] as List).map((q) => TBL0002.fromMap(q as Map<String, dynamic>)).toList();
    });
    blocTest<LinkBloc, LinkState>(
      'should emit full list when value is null',
      build: () => linkBloc,
      act: (bloc) => bloc.search(null),
      expect: () => [
        predicate<LinkState>((state) {
          return state.questionsFiltered.length == state.questions.length;
        }),
      ],
    );

    blocTest<LinkBloc, LinkState>(
      'should emit full list when value is empty',
      build: () => linkBloc,
      act: (bloc) => bloc.search(''),
      expect: () => [
        predicate<LinkState>((state) {
          return state.questionsFiltered.length == state.questions.length;
        }),
      ],
    );

    blocTest<LinkBloc, LinkState>(
      'should emit filtered list when value is not empty',
      build: () => linkBloc,
      seed: () => LinkState.initial().copyWith(
        questions: listOfQuestions,
        questionsFiltered: listOfQuestions,
      ),
      act: (bloc) => bloc.search('1'),
      expect: () => [
        predicate<LinkState>((state) {
          return state.questionsFiltered.length <= state.questions.length;
        }),
      ],
    );

    blocTest<LinkBloc, LinkState>(
      'should filter correctly by specific text',
      build: () => linkBloc,
      seed: () => LinkState.initial().copyWith(
        questions: listOfQuestions,
        questionsFiltered: listOfQuestions,
      ),
      act: (bloc) => bloc.search('1'),
      expect: () => [
        predicate<LinkState>((state) {
          return state.questionsFiltered.every((question) => question.index == 1);
        }),
      ],
    );

    blocTest<LinkBloc, LinkState>(
      'should emit empty list when no match is found',
      build: () => linkBloc,
      seed: () => LinkState.initial().copyWith(
        questions: listOfQuestions,
        questionsFiltered: listOfQuestions,
      ),
      act: (bloc) => bloc.search('6'),
      expect: () => [
        predicate<LinkState>((state) {
          return state.questionsFiltered.isEmpty;
        }),
      ],
    );
  });

  group('LinkBloc - Tests for the link() method', () {
    late TBL0003 mockQuestionReference;

    setUp(() {
      mockQuestionReference = TBL0003.instance();
    });
    blocTest<LinkBloc, LinkState>(
      'should emit linking and then linked when linking is successful',
      build: () => linkBloc,
      seed: () => LinkState.initial().copyWith(
        noteSelected: TBL0001.instance().copyWith(id: 'any_id'),
      ),
      setUp: () {
        when(mockLinkService.link(any)).thenAnswer((_) => Future.value());
        when(mockLinkService.findQuestionsByNote(any)).thenAnswer((_) => Future.value([]));
      },
      act: (bloc) => bloc.link(mockQuestionReference, 'any_id', 1),
      expect: () => [
        predicate<LinkState>((state) => state.status == LinkStatus.linking),
        predicate<LinkState>((state) {
          return state.status == LinkStatus.linked &&
              state.questions.isEmpty &&
              state.questionsFiltered.isEmpty &&
              state.message == 'Questão vinculada com sucesso';
        }),
      ],
    );

    blocTest<LinkBloc, LinkState>(
      'should emit error when linkService.link fails',
      build: () => linkBloc,
      setUp: () {
        when(mockLinkService.link(any)).thenThrow(ErrorSupabaseException());
      },
      act: (bloc) => bloc.link(mockQuestionReference, 'question_456', 1),
      expect: () => [
        predicate<LinkState>((state) => state.status == LinkStatus.linking),
        predicate<LinkState>((state) {
          return state.status == LinkStatus.error && state.message == ErrorSupabaseException().toString();
        }),
      ],
    );
  });

  group('LinkBloc - Tests for the removeLink() method', () {
    blocTest<LinkBloc, LinkState>(
      'should emit linking and then linked when removal is successful',
      build: () => linkBloc,
      seed: () => LinkState.initial().copyWith(
        noteSelected: TBL0001.instance().copyWith(id: 'any_id'),
      ),
      setUp: () {
        when(mockLinkService.removeLink(any)).thenAnswer((_) => Future.value());
        when(mockLinkService.findQuestionsByNote(any)).thenAnswer((_) => Future.value([]));
      },
      act: (bloc) => bloc.removeLink(TBL0002.instance()),
      expect: () => [
        predicate<LinkState>((state) => state.status == LinkStatus.linking),
        predicate<LinkState>((state) {
          return state.status == LinkStatus.linked &&
              state.questions.isEmpty &&
              state.questionsFiltered.isEmpty &&
              state.message == 'Questão desvinculada com sucesso';
        }),
      ],
    );

    blocTest<LinkBloc, LinkState>(
      'should emit error when removeLink fails',
      build: () => linkBloc,
      setUp: () {
        when(mockLinkService.removeLink(any)).thenThrow(ErrorSupabaseException());
      },
      act: (bloc) => bloc.removeLink(TBL0002.instance()),
      expect: () => [
        predicate<LinkState>((state) => state.status == LinkStatus.linking),
        predicate<LinkState>((state) {
          return state.status == LinkStatus.error && state.message == ErrorSupabaseException().toString();
        }),
      ],
    );
  });
}
