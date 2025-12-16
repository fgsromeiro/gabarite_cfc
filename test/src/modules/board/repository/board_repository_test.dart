import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture_reader.dart';
import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockNetworkVerifier mockNetworkVerifier;
  late MockDataManager mockDataManager;
  late BoardRepository repository;
  late List<Map<String, dynamic>> dataList;
  late TBL0003 mockQuestion;

  setUpAll(
    () {
      dataList = (fixture('list_of_questions_reference.json')['questions'] as List).cast<Map<String, dynamic>>();
      mockQuestion = TBL0003.instance();
      mockNetworkVerifier = MockNetworkVerifier();
      mockDataManager = MockDataManager();
      repository = BoardRepositoryImpl(
        dataManager: mockDataManager,
        networkVerifier: mockNetworkVerifier,
      );
    },
  );

  tearDown(
    () {
      reset(mockNetworkVerifier);
      reset(mockDataManager);
    },
  );

  group('findAllQuestions', () {
    test(
      'should return a list of questionBase correctly',
      () async {
        when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
        when(mockDataManager.findAll(dto: anyNamed('dto'))).thenAnswer((_) async => dataList);

        final result = await repository.findAll();

        expect(result, isA<List<TBL0003>>());
        verify(mockNetworkVerifier.verifyConnection()).called(1);
        verify(mockDataManager.findAll(dto: anyNamed('dto'))).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());

        expect(() => repository.findAll(), throwsA(isA<ConnectionInternetErrorException>()));
        verifyZeroInteractions(mockDataManager);
      },
    );

    test(
      'should launch an exception ErrorSupabaseException when giving error requisition',
      () async {
        when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
        when(mockDataManager.findAll(dto: anyNamed('dto'))).thenThrow(ErrorSupabaseException());

        expect(() => repository.findAll(), throwsA(isA<ErrorSupabaseException>()));
        verify(mockNetworkVerifier.verifyConnection()).called(1);
      },
    );
  });

  group(
    'updateQuestionBase',
    () {
      test(
        'should update the data correctly',
        () async {
          when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => true);
          when(mockDataManager.update(dto: anyNamed('dto'))).thenAnswer((_) async {});

          expect(() => repository.update(mockQuestion), returnsNormally);
          verify(mockNetworkVerifier.verifyConnection()).called(1);
        },
      );

      test(
        'should launch a ConnectionInternetException exception when you are without internet connection',
        () async {
          when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => false);
          when(mockDataManager.update(dto: anyNamed('dto'))).thenThrow(ConnectionInternetErrorException());

          expect(() => repository.update(mockQuestion), throwsA(isA<ConnectionInternetErrorException>()));
          verify(mockNetworkVerifier.verifyConnection()).called(1);
          verifyZeroInteractions(mockDataManager);
        },
      );

      test(
        'should launch the exception ErrorSupabaseException by updating the data',
        () async {
          when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => true);
          when(mockDataManager.update(dto: anyNamed('dto'))).thenThrow(ErrorSupabaseException());

          expect(() => repository.update(mockQuestion), throwsA(isA<ErrorSupabaseException>()));
          verify(mockNetworkVerifier.verifyConnection()).called(1);
        },
      );
    },
  );
}
