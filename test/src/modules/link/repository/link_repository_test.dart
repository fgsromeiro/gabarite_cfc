import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../fixture_reader.dart';
import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockNetworkVerifier mockNetworkVerifier;
  late MockDataManager mockDataManager;
  late LinkRepository repository;
  late List<Map<String, dynamic>> dataList;
  late FunctionLinkDTO dto;

  setUpAll(
    () {
      dataList = (fixture('list_of_questions_by_note.json')['questions'] as List).cast<Map<String, dynamic>>();
      mockNetworkVerifier = MockNetworkVerifier();
      mockDataManager = MockDataManager();
      repository = LinkRepositoryImpl(dataManager: mockDataManager, networkVerifier: mockNetworkVerifier);
      dto = FunctionLinkDTO(id: 'any_id');
    },
  );

  tearDown(
    () {
      reset(mockNetworkVerifier);
      reset(mockDataManager);
    },
  );

  group('findAllQuestionsByNote', () {
    test(
      'should return a list of questionsByNote correctly',
      () async {
        when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
        when(mockDataManager.findAll(dto: anyNamed('dto'))).thenAnswer((_) async => dataList);

        final result = await repository.findQuestionsByNote('any_id');

        expect(result, isA<List<TBL0002>>());
        verify(mockNetworkVerifier.verifyConnection()).called(1);
        verify(mockDataManager.findAll(dto: anyNamed('dto'))).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());

        expect(() => repository.findQuestionsByNote('any_id'), throwsA(isA<ConnectionInternetErrorException>()));
        verifyZeroInteractions(mockDataManager);
      },
    );

    test(
      'should launch an exception ErrorSupabaseException when giving error requisition',
      () async {
        when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
        when(mockDataManager.findAll(dto: anyNamed('dto'))).thenThrow(ErrorSupabaseException());

        expect(() => repository.findQuestionsByNote('any_id'), throwsA(isA<ErrorSupabaseException>()));
        verify(mockNetworkVerifier.verifyConnection()).called(1);
      },
    );
  });

  group('link', () {
    test('should call networkVerifier and dataManager and complete successfully', () async {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
      when(mockDataManager.update(dto: anyNamed('dto'))).thenAnswer((_) async {});

      await repository.link(dto);

      verify(mockNetworkVerifier.verifyConnection()).called(1);
      verify(mockDataManager.update(dto: anyNamed('dto'))).called(1);
    });

    test('should rethrow ConnectionInternetErrorException if network verification fails', () async {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());

      expect(() => repository.link(dto), throwsA(isA<ConnectionInternetErrorException>()));

      verify(mockNetworkVerifier.verifyConnection()).called(1);
      verifyNever(mockDataManager.update(dto: anyNamed('dto')));
    });

    test('should rethrow ErrorSupabaseException if data update fails', () async {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
      when(mockDataManager.update(dto: anyNamed('dto'))).thenThrow(ErrorSupabaseException());

      expect(() => repository.link(dto), throwsA(isA<ErrorSupabaseException>()));

      verify(mockNetworkVerifier.verifyConnection()).called(1);
    });
  });

  group('removeLink', () {
    test('should verify network, call dataManager.delete() and complete successfully', () async {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});

      await repository.removeLink(dto);

      verify(mockNetworkVerifier.verifyConnection()).called(1);
      verify(mockDataManager.update(dto: anyNamed('dto'))).called(1);
    });

    test('should rethrow ConnectionInternetErrorException if network verification fails', () async {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());

      expect(() => repository.removeLink(dto), throwsA(isA<ConnectionInternetErrorException>()));

      verify(mockNetworkVerifier.verifyConnection()).called(1);
      verifyNever(mockDataManager.update(dto: anyNamed('dto')));
    });

    test('should rethrow ErrorSupabaseException if dataManager.update() fails', () async {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
      when(mockDataManager.update(dto: anyNamed('dto'))).thenThrow(ErrorSupabaseException());

      expect(() => repository.removeLink(dto), throwsA(isA<ErrorSupabaseException>()));
      verify(mockNetworkVerifier.verifyConnection()).called(1);
    });
  });
}
