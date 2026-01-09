import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../../fixture_reader.dart';
import '../../../../../mocks/mocks.mocks.dart';

void main() {
  late MockVisibilityService mockVisibilityService;
  late MockBoardService mockBoardService;
  late MockNoteService mockNoteService;
  late VisibilityBloc bloc;
  late Map<String, dynamic> mockResponseQuestionsByNote;
  late Map<String, dynamic> mockResponseNote;
  late Map<String, dynamic> mockResponseQuestionsReference;

  setUp(() {
    mockVisibilityService = MockVisibilityService();
    mockBoardService = MockBoardService();
    mockNoteService = MockNoteService();
    mockResponseQuestionsByNote = fixture('list_of_questions_by_note.json');
    mockResponseNote = fixture('list_of_notes.json');
    mockResponseQuestionsReference = fixture('list_of_questions_reference.json');
    bloc = VisibilityBloc(
      service: mockVisibilityService,
      noteService: mockNoteService,
      boardService: mockBoardService,
    );
  });

  tearDown(() {
    bloc.close();
    reset(mockVisibilityService);
    reset(mockBoardService);
    reset(mockNoteService);
  });

  group('VisibilityBloc - Tests for the load() method', () {
    late List<TBL0002> mockListOfQuestionsByNote;
    late List<TBL0001> mockListOfNotes;
    late List<TBL0003> mockListOfQuestionReference;
    late VisibilityState initialState;

    setUp(() {
      mockListOfQuestionsByNote = List.of(
        (mockResponseQuestionsByNote['questions'] as List).map((e) => TBL0002.fromMap(e as Map<String, dynamic>)),
      );
      mockListOfNotes =
          List.of((mockResponseNote['notes'] as List).map((e) => TBL0001.fromMap(e as Map<String, dynamic>)));
      mockListOfQuestionReference = List.of(
        (mockResponseQuestionsReference['questions'] as List).map((e) => TBL0003.fromMap(e as Map<String, dynamic>)),
      );
      initialState = VisibilityState.initial();
    });

    blocTest<VisibilityBloc, VisibilityState>(
      'should emit a new loaded state when calling the load() method successfully',
      setUp: () {
        when(mockVisibilityService.loadAllQuestions()).thenAnswer((_) async => mockListOfQuestionsByNote);
        when(mockNoteService.findAllNotes()).thenAnswer((_) async => mockListOfNotes);
        when(mockBoardService.loadAllQuestions()).thenAnswer((_) async => mockListOfQuestionReference);
      },
      build: () => bloc,
      act: (bloc) => bloc.load(),
      expect: () => [
        initialState.copyWith(status: VisibilityStatus.loading),
        initialState.copyWith(
            status: VisibilityStatus.loaded,
            questions: bloc.updateListQuestionVisibility(
              mockListOfQuestionReference,
              mockListOfQuestionsByNote,
              mockListOfNotes,
            )),
      ],
      verify: (bloc) {
        verify(mockVisibilityService.loadAllQuestions()).called(1);
        verify(mockNoteService.findAllNotes()).called(1);
        verify(mockBoardService.loadAllQuestions()).called(1);
        expect(bloc.state.status, VisibilityStatus.loaded);
      },
    );

    blocTest<VisibilityBloc, VisibilityState>(
      'should emit a new error state when failing to call the loadAllQuestions() method',
      setUp: () {
        when(mockVisibilityService.loadAllQuestions()).thenThrow(CustomException('any_message', 500));
      },
      build: () => bloc,
      act: (bloc) => bloc.load(),
      expect: () => [
        initialState.copyWith(status: VisibilityStatus.loading),
        initialState.copyWith(status: VisibilityStatus.error, errorMessage: 'any_message'),
      ],
      verify: (bloc) {
        verify(mockVisibilityService.loadAllQuestions()).called(1);
        verifyNever(mockNoteService.findAllNotes());
        verifyNever(mockBoardService.loadAllQuestions());
        expect(bloc.state.status, VisibilityStatus.error);
        expect(bloc.state.errorMessage, 'any_message');
      },
    );
    blocTest<VisibilityBloc, VisibilityState>(
      'should emit a new error state when failing to call the findAllNotes() method',
      setUp: () {
        when(mockVisibilityService.loadAllQuestions()).thenAnswer((_) async => mockListOfQuestionsByNote);
        when(mockNoteService.findAllNotes()).thenThrow(CustomException('any_message', 500));
      },
      build: () => bloc,
      act: (bloc) => bloc.load(),
      expect: () => [
        initialState.copyWith(status: VisibilityStatus.loading),
        initialState.copyWith(status: VisibilityStatus.error, errorMessage: 'any_message'),
      ],
      verify: (bloc) {
        verify(mockVisibilityService.loadAllQuestions()).called(1);
        verify(mockNoteService.findAllNotes()).called(1);
        verifyNever(mockBoardService.loadAllQuestions());
        expect(bloc.state.status, VisibilityStatus.error);
        expect(bloc.state.errorMessage, 'any_message');
      },
    );
    blocTest<VisibilityBloc, VisibilityState>(
      'should emit a new error state when failing to call the loadAllQuestions() method from BoardService',
      setUp: () {
        when(mockVisibilityService.loadAllQuestions()).thenAnswer((_) async => mockListOfQuestionsByNote);
        when(mockNoteService.findAllNotes()).thenAnswer((_) async => mockListOfNotes);
        when(mockBoardService.loadAllQuestions()).thenThrow(CustomException('any_message', 500));
      },
      build: () => bloc,
      act: (bloc) => bloc.load(),
      expect: () => [
        initialState.copyWith(status: VisibilityStatus.loading),
        initialState.copyWith(status: VisibilityStatus.error, errorMessage: 'any_message'),
      ],
      verify: (bloc) {
        verify(mockVisibilityService.loadAllQuestions()).called(1);
        verify(mockNoteService.findAllNotes()).called(1);
        verify(mockBoardService.loadAllQuestions()).called(1);
        expect(bloc.state.status, VisibilityStatus.error);
        expect(bloc.state.errorMessage, 'any_message');
      },
    );
  });
  group('VisibilityBloc - Tests for the onVisibility() method', () {
    late VisibilityState initialState;
    late QuestionVisibility mockQuestion;

    setUp(() {
      initialState = VisibilityState.initial();
      mockQuestion = QuestionVisibility(questionBase: TBL0003.instance());
    });

    blocTest<VisibilityBloc, VisibilityState>(
      'should emit a new loaded state when calling the onVisibility() method successfully',
      seed: () => initialState.copyWith(status: VisibilityStatus.loaded),
      setUp: () => when(mockVisibilityService.setVisibility(any)).thenAnswer((_) async => Future.value()),
      build: () => bloc,
      act: (bloc) => bloc.onVisibility(mockQuestion, true),
      expect: () => [
        initialState.copyWith(status: VisibilityStatus.changing),
        initialState.copyWith(status: VisibilityStatus.loaded, questions: List.empty()),
      ],
      verify: (bloc) {
        verify(mockVisibilityService.setVisibility(any)).called(1);
        expect(bloc.state.status, VisibilityStatus.loaded);
      },
    );
    blocTest<VisibilityBloc, VisibilityState>(
      'should emit a new error state when failing to call the setVisibility() method',
      seed: () => initialState.copyWith(status: VisibilityStatus.loaded),
      setUp: () => when(mockVisibilityService.setVisibility(any)).thenThrow(CustomException('any_message', 500)),
      build: () => bloc,
      act: (bloc) => bloc.onVisibility(mockQuestion, true),
      expect: () => [
        initialState.copyWith(status: VisibilityStatus.changing),
        initialState.copyWith(status: VisibilityStatus.error, errorMessage: 'any_message'),
      ],
      verify: (bloc) {
        verify(mockVisibilityService.setVisibility(any)).called(1);
        expect(bloc.state.status, VisibilityStatus.error);
        expect(bloc.state.errorMessage, 'any_message');
      },
    );
  });
  group('VisibilityBloc - Tests for the onVisibilityAll() method', () {
    late VisibilityState initialState;

    setUp(() => initialState = VisibilityState.initial());

    blocTest<VisibilityBloc, VisibilityState>(
      'should emit a new loaded state when calling the onVisibility() method successfully',
      seed: () => initialState.copyWith(status: VisibilityStatus.loaded),
      setUp: () => when(mockVisibilityService.changeVisibilityAll(any)).thenAnswer((_) async => Future.value()),
      build: () => bloc,
      act: (bloc) => bloc.onVisibilityAll(true),
      expect: () => [
        initialState.copyWith(status: VisibilityStatus.changing),
        initialState.copyWith(status: VisibilityStatus.loaded, questions: List.empty()),
      ],
      verify: (bloc) {
        verify(mockVisibilityService.changeVisibilityAll(any)).called(1);
        expect(bloc.state.status, VisibilityStatus.loaded);
      },
    );
    blocTest<VisibilityBloc, VisibilityState>(
      'should emit a new error state when failing to call the changeVisibilityAll() method',
      seed: () => initialState.copyWith(status: VisibilityStatus.loaded),
      setUp: () => when(mockVisibilityService.changeVisibilityAll(any)).thenThrow(CustomException('any_message', 500)),
      build: () => bloc,
      act: (bloc) => bloc.onVisibilityAll(true),
      expect: () => [
        initialState.copyWith(status: VisibilityStatus.changing),
        initialState.copyWith(status: VisibilityStatus.error, errorMessage: 'any_message'),
      ],
      verify: (bloc) {
        verify(mockVisibilityService.changeVisibilityAll(any)).called(1);
        expect(bloc.state.status, VisibilityStatus.error);
        expect(bloc.state.errorMessage, 'any_message');
      },
    );

    // blocTest<VisibilityBloc, VisibilityState>(
    //   'should emit a new error state when failing to call the loadAllQuestions() method from BoardService',
    //   setUp: () {
    //     when(mockVisibilityService.loadAllQuestions()).thenAnswer((_) async => mockListOfQuestionsByNote);
    //     when(mockNoteService.findAllNotes()).thenAnswer((_) async => mockListOfNotes);
    //     when(mockBoardService.loadAllQuestions()).thenThrow(CustomException('any_message', 500));
    //   },
    //   build: () => bloc,
    //   act: (bloc) => bloc.load(),
    //   expect: () => [
    //     initialState.copyWith(status: VisibilityStatus.loading),
    //     initialState.copyWith(status: VisibilityStatus.error, errorMessage: 'any_message'),
    //   ],
    //   verify: (bloc) {
    //     verify(mockVisibilityService.loadAllQuestions()).called(1);
    //     verify(mockNoteService.findAllNotes()).called(1);
    //     verify(mockBoardService.loadAllQuestions()).called(1);
    //     expect(bloc.state.status, VisibilityStatus.error);
    //     expect(bloc.state.errorMessage, 'any_message');
    //   },
    // );
  });
  // group('SettingBloc - Tests for the reset() method', () {
  //   late SettingState initialState;
  //   late Note mockNote;

  //   setUp(() {
  //     initialState = SettingState.initial();
  //     mockNote = Note.fromMap(mockResponseNote);
  //   });

  //   blocTest<SettingBloc, SettingState>(
  //     'should emit a new success state when calling the reset() method successfully',
  //     setUp: () {
  //       when(mockVisibilityService.reset()).thenAnswer((_) async => Future.value());
  //     },
  //     build: () => bloc,
  //     act: (bloc) => bloc.reset(mockNote),
  //     expect: () => [
  //       initialState.copyWith(status: SettingStatus.loading),
  //       initialState.copyWith(status: SettingStatus.success),
  //     ],
  //     verify: (bloc) {
  //       verify(mockVisibilityService.reset()).called(1);
  //       expect(bloc.state.status, SettingStatus.success);
  //     },
  //   );

  //   blocTest<SettingBloc, SettingState>(
  //     'should emit a new error state when failing to call the reset() method',
  //     setUp: () {
  //       when(mockVisibilityService.reset()).thenThrow(CustomException('any_message', 500));
  //     },
  //     build: () => bloc,
  //     act: (bloc) => bloc.reset(mockNote),
  //     expect: () => [
  //       initialState.copyWith(status: SettingStatus.loading),
  //       initialState.copyWith(status: SettingStatus.error, message: 'any_message'),
  //     ],
  //     verify: (bloc) {
  //       verify(mockVisibilityService.reset()).called(1);
  //       expect(bloc.state.status, SettingStatus.error);
  //       expect(bloc.state.message, 'any_message');
  //     },
  //   );
  // });
  // group('SettingBloc - Tests for the updatePermission() method', () {
  //   late SettingState initialState;
  //   late Permission mockPermission;

  //   setUp(() {
  //     initialState = SettingState.initial();
  //     mockPermission = Permission.fromMap(mockResponsePermission);
  //   });

  //   blocTest<SettingBloc, SettingState>(
  //     'should emit a new success state when calling the updatePermission() method successfully',
  //     setUp: () {
  //       when(mockBoardService.updatePermission(mockPermission)).thenAnswer((_) async => Future.value());
  //     },
  //     build: () => bloc,
  //     act: (bloc) => bloc.updatePermission(mockPermission),
  //     expect: () => [
  //       initialState.copyWith(status: SettingStatus.updating),
  //       initialState.copyWith(status: SettingStatus.updated),
  //     ],
  //     verify: (bloc) {
  //       verify(mockBoardService.updatePermission(mockPermission)).called(1);
  //       expect(bloc.state.status, SettingStatus.updated);
  //     },
  //   );

  //   blocTest<SettingBloc, SettingState>(
  //     'should emit a new error state when failing to call the updatePermission() method',
  //     setUp: () {
  //       when(mockBoardService.updatePermission(mockPermission)).thenThrow(CustomException('any_message', 500));
  //     },
  //     build: () => bloc,
  //     act: (bloc) => bloc.updatePermission(mockPermission),
  //     expect: () => [
  //       initialState.copyWith(status: SettingStatus.updating),
  //       initialState.copyWith(status: SettingStatus.error, message: 'any_message'),
  //     ],
  //     verify: (bloc) {
  //       verify(mockBoardService.updatePermission(mockPermission)).called(1);
  //       expect(bloc.state.status, SettingStatus.error);
  //       expect(bloc.state.message, 'any_message');
  //     },
  //   );
  // });
  // group('SettingBloc - Tests for the updateDisplay() method', () {
  //   late SettingState initialState;
  //   late Display mockDisplay;

  //   setUp(() {
  //     initialState = SettingState.initial();
  //     mockDisplay = Display.fromMap(mockResponseQuestionsReference);
  //   });

  //   blocTest<SettingBloc, SettingState>(
  //     'should emit a new success state when calling the updateDisplay() method successfully',
  //     setUp: () {
  //       when(mockVisibilityService.toggleButtons(mockDisplay)).thenAnswer((_) async => Future.value());
  //     },
  //     build: () => bloc,
  //     act: (bloc) => bloc.updateDisplay(mockDisplay),
  //     expect: () => [
  //       initialState.copyWith(status: SettingStatus.updating),
  //       initialState.copyWith(status: SettingStatus.updated),
  //     ],
  //     verify: (bloc) {
  //       verify(mockVisibilityService.toggleButtons(mockDisplay)).called(1);
  //       expect(bloc.state.status, SettingStatus.updated);
  //     },
  //   );

  //   blocTest<SettingBloc, SettingState>(
  //     'should emit a new error state when failing to call the updateDisplay() method',
  //     setUp: () {
  //       when(mockVisibilityService.toggleButtons(mockDisplay)).thenThrow(CustomException('any_message', 500));
  //     },
  //     build: () => bloc,
  //     act: (bloc) => bloc.updateDisplay(mockDisplay),
  //     expect: () => [
  //       initialState.copyWith(status: SettingStatus.updating),
  //       initialState.copyWith(status: SettingStatus.error, message: 'any_message'),
  //     ],
  //     verify: (bloc) {
  //       verify(mockVisibilityService.toggleButtons(mockDisplay)).called(1);
  //       expect(bloc.state.status, SettingStatus.error);
  //       expect(bloc.state.message, 'any_message');
  //     },
  //   );
  // });
}
