import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture_reader.dart';
import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockNetworkVerifier mockNetworkVerifier;
  late MockDataManager mockDataManager;
  late NoteRepository repository;
  late List<Map<String, dynamic>> dataList;
  late TBL0001 note;

  setUpAll(
    () {
      dataList = (fixture('list_of_notes.json')['notes'] as List).cast<Map<String, dynamic>>();
      mockNetworkVerifier = MockNetworkVerifier();
      mockDataManager = MockDataManager();
      repository = NoteRepositoryImpl(
        dataManager: mockDataManager,
        networkVerifier: mockNetworkVerifier,
      );
      note = TBL0001.instance();
    },
  );

  tearDown(
    () {
      reset(mockNetworkVerifier);
      reset(mockDataManager);
    },
  );

  group('findAllNotes', () {
    test(
      'should return a list of notes correctly',
      () async {
        when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => true);
        when(mockDataManager.findAll(dto: anyNamed('dto'))).thenAnswer((_) async => dataList);

        final result = await repository.findAllNotes();

        expect(result, isA<List<TBL0001>>());
        verify(mockNetworkVerifier.verifyConnection()).called(1);
        verify(mockDataManager.findAll(dto: anyNamed('dto'))).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());

        expect(() => repository.findAllNotes(), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockNetworkVerifier.verifyConnection()).called(1);
        verifyZeroInteractions(mockDataManager);
      },
    );

    test(
      'should launch an exception ErrorSupabaseException when giving error requisition',
      () async {
        when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => true);
        when(mockDataManager.findAll(dto: anyNamed('dto'))).thenThrow(ErrorSupabaseException());

        expect(() => repository.findAllNotes(), throwsA(isA<ErrorSupabaseException>()));
        verify(mockNetworkVerifier.verifyConnection()).called(1);
      },
    );
  });

  group(
    'updateNotes',
    () {
      test(
        'should update the data correctly',
        () async {
          when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => {});
          when(mockDataManager.update(dto: anyNamed('dto'))).thenAnswer((_) async {});

          expect(() => repository.update(note), returnsNormally);
          verify(mockNetworkVerifier.verifyConnection()).called(1);
        },
      );

      test(
        'should launch a ConnectionInternetException exception when you are without internet connection',
        () async {
          when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());

          expect(() => repository.update(note), throwsA(isA<ConnectionInternetErrorException>()));
          verify(mockNetworkVerifier.verifyConnection()).called(1);
          verifyZeroInteractions(mockDataManager);
        },
      );

      test(
        'should launch the 1nd exception ErrorSupabaseException by updating the data',
        () async {
          when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => {});
          when(mockDataManager.update(dto: anyNamed('dto'))).thenThrow(ErrorSupabaseException());

          expect(() => repository.update(note), throwsA(isA<ErrorSupabaseException>()));
          verify(mockNetworkVerifier.verifyConnection()).called(1);
        },
      );
    },
  );
}
