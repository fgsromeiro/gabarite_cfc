import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../fixture_reader.dart';
import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockVisibilityRepository mockRepository;
  late VisibilityService service;
  late Map<String, dynamic> mockDataNoteMap;
  late VisibilityDTO mockVisibilityDTO;

  setUp(
    () {
      mockDataNoteMap = fixture('list_of_questions_by_note.json');
      mockVisibilityDTO = VisibilityDTO(idQuestionBase: '', isVisible: true);
      mockRepository = MockVisibilityRepository();
      service = VisibilityServiceImpl(repository: mockRepository);
    },
  );

  tearDown(() => reset(mockRepository));

  group('Test method setVisibility()', () {
    void mockRequest() {
      when(mockRepository.setVisibility(any)).thenAnswer((_) async => Future.value());
    }

    void mockRequestError(CustomException exception) {
      when(mockRepository.setVisibility(any)).thenThrow(exception);
    }

    test(
      'should check setVisibility for the correct parameters',
      () async {
        mockRequest();

        await expectLater(() => service.setVisibility(mockVisibilityDTO), returnsNormally);
        verify(mockRepository.setVisibility(any)).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestError(ConnectionInternetErrorException());

        await expectLater(
            () => service.setVisibility(mockVisibilityDTO), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockRepository.setVisibility(any)).called(1);
      },
    );
    test(
      'should launch an exception ErrorSupabaseException when giving error requisition',
      () async {
        mockRequestError(ErrorSupabaseException());

        await expectLater(() => service.setVisibility(mockVisibilityDTO), throwsA(isA<ErrorSupabaseException>()));
        verify(mockRepository.setVisibility(any)).called(1);
      },
    );
  });
  group('Test method changeVisibilityAll()', () {
    void mockRequest() {
      when(mockRepository.changeVisibilityAll(any)).thenAnswer((_) async => Future.value());
    }

    void mockRequestError(CustomException exception) {
      when(mockRepository.changeVisibilityAll(any)).thenThrow(exception);
    }

    test(
      'should check changeVisibilityAll for the correct parameters',
      () async {
        mockRequest();

        await expectLater(() => service.changeVisibilityAll(mockVisibilityDTO), returnsNormally);
        verify(mockRepository.changeVisibilityAll(any)).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestError(ConnectionInternetErrorException());

        await expectLater(
            () => service.changeVisibilityAll(mockVisibilityDTO), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockRepository.changeVisibilityAll(any)).called(1);
      },
    );

    test(
      'should launch an exception ErrorSupabaseException when giving error requisition',
      () async {
        mockRequestError(ErrorSupabaseException());

        await expectLater(() => service.changeVisibilityAll(mockVisibilityDTO), throwsA(isA<ErrorSupabaseException>()));
        verify(mockRepository.changeVisibilityAll(any)).called(1);
      },
    );
  });

  group('Test method loadAllQuestions()', () {
    late List<TBL0002> mockQuestionsByNoteList;

    setUp(() {
      mockQuestionsByNoteList =
          (mockDataNoteMap['questions'] as List).map((e) => TBL0002.fromMap(e as Map<String, dynamic>)).toList();
    });

    void mockRequest() {
      when(mockRepository.loadAllQuestions()).thenAnswer((_) async => mockQuestionsByNoteList);
    }

    void mockRequestError(CustomException exception) {
      when(mockRepository.loadAllQuestions()).thenThrow(exception);
    }

    test(
      'should check loadAllQuestions for the correct parameters',
      () async {
        mockRequest();

        await expectLater(() => service.loadAllQuestions(), returnsNormally);
        verify(mockRepository.loadAllQuestions()).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestError(ConnectionInternetErrorException());

        await expectLater(() => service.loadAllQuestions(), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockRepository.loadAllQuestions()).called(1);
      },
    );

    test(
      'should launch an exception ErrorSupabaseException when giving error requisition',
      () async {
        mockRequestError(ErrorSupabaseException());

        await expectLater(() => service.loadAllQuestions(), throwsA(isA<ErrorSupabaseException>()));
        verify(mockRepository.loadAllQuestions()).called(1);
      },
    );
  });
}
