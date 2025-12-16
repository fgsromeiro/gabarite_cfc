import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../fixture_reader.dart';
import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockBoardRepository mockBoardRepository;
  late BoardService service;
  late List<TBL0003> dataList;
  late TBL0003 mockQuestion;

  setUpAll(
    () {
      dataList = [TBL0003.fromMap(fixture('question_reference.json'))];
      mockBoardRepository = MockBoardRepository();
      mockQuestion = TBL0003.instance();
      service = BoardServiceImpl(repository: mockBoardRepository);
    },
  );

  tearDown(
    () {
      reset(mockBoardRepository);
    },
  );

  group('findAllQuestionBase', () {
    void mockRequest() {
      when(mockBoardRepository.findAll()).thenAnswer((_) async => dataList);
    }

    void mockRequestError(CustomException exception) {
      when(mockBoardRepository.findAll()).thenThrow(exception);
    }

    test(
      'should return a list of questionBase correctly',
      () async {
        mockRequest();

        final result = await service.loadAllQuestions();

        expect(result, isA<List<TBL0003>>());
        verify(mockBoardRepository.findAll()).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestError(ConnectionInternetErrorException());

        expect(() => service.loadAllQuestions(), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockBoardRepository.findAll()).called(1);
      },
    );

    test(
      'should launch an exception ErrorSupabaseException when giving error requisition',
      () async {
        mockRequestError(ErrorSupabaseException());

        expect(() => service.loadAllQuestions(), throwsA(isA<ErrorSupabaseException>()));
        verify(mockBoardRepository.findAll()).called(1);
      },
    );
  });

  group(
    'updateQuestions',
    () {
      void mockRequest() {
        when(mockBoardRepository.update(any)).thenAnswer((_) async {
          return;
        });
      }

      void mockRequestError(CustomException exception) {
        when(mockBoardRepository.update(any)).thenThrow(exception);
      }

      test(
        'should update the data correctly',
        () async {
          mockRequest();

          expect(() => service.fillQuestion(mockQuestion), returnsNormally);
          verify(mockBoardRepository.update(any)).called(1);
        },
      );

      test(
        'should launch a ConnectionInternetException exception when you are without internet connection',
        () async {
          mockRequestError(ConnectionInternetErrorException());

          expect(() => service.fillQuestion(mockQuestion), throwsA(isA<ConnectionInternetErrorException>()));
          verify(mockBoardRepository.update(any)).called(1);
        },
      );

      test(
        'should launch the 1nd exception ErrorSupabaseException by updating the data',
        () async {
          mockRequestError(ErrorSupabaseException());

          expect(() => service.fillQuestion(mockQuestion), throwsA(isA<ErrorSupabaseException>()));
          verify(mockBoardRepository.update(any)).called(1);
        },
      );
    },
  );
}
