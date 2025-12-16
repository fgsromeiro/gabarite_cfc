import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../fixture_reader.dart';
import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockNoteRepository mockNoteRepository;
  late NoteService service;
  late List<TBL0001> dataList;
  late TBL0001 note;

  setUpAll(
    () {
      dataList = [TBL0001.fromMap(fixture('note.json'))];
      mockNoteRepository = MockNoteRepository();
      note = TBL0001.instance();
      service = NoteServiceImpl(repository: mockNoteRepository);
    },
  );

  tearDown(
    () {
      reset(mockNoteRepository);
    },
  );

  group('findAllNotes', () {
    void mockRequest() {
      when(mockNoteRepository.findAllNotes()).thenAnswer((_) async => dataList);
    }

    void mockRequestError(CustomException exception) {
      when(mockNoteRepository.findAllNotes()).thenThrow(exception);
    }

    test(
      'should return a list of notes correctly',
      () async {
        mockRequest();

        final result = await service.findAllNotes();

        expect(result, isA<List<TBL0001>>());
        verify(mockNoteRepository.findAllNotes()).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestError(ConnectionInternetErrorException());

        expect(() => service.findAllNotes(), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockNoteRepository.findAllNotes()).called(1);
      },
    );

    test(
      'should launch an exception ErrorSupabaseException when giving error requisition',
      () async {
        mockRequestError(ErrorSupabaseException());

        expect(() => service.findAllNotes(), throwsA(isA<ErrorSupabaseException>()));
        verify(mockNoteRepository.findAllNotes()).called(1);
      },
    );
  });

  group(
    'updateNotes',
    () {
      void mockRequest() {
        when(mockNoteRepository.update(any)).thenAnswer((_) async {});
      }

      void mockRequestError(CustomException exception) {
        when(mockNoteRepository.update(any)).thenThrow(exception);
      }

      test(
        'should update the data correctly',
        () async {
          mockRequest();

          expect(() => service.update(note), returnsNormally);
          verify(mockNoteRepository.update(any)).called(1);
        },
      );

      test(
        'should launch a ConnectionInternetException exception when you are without internet connection',
        () async {
          mockRequestError(ConnectionInternetErrorException());

          expect(() => service.update(note), throwsA(isA<ConnectionInternetErrorException>()));
          verify(mockNoteRepository.update(any)).called(1);
        },
      );

      test(
        'should launch the 1nd exception ErrorSupabaseException by updating the data',
        () async {
          mockRequestError(ErrorSupabaseException());

          expect(() => service.update(note), throwsA(isA<ErrorSupabaseException>()));
          verify(mockNoteRepository.update(any)).called(1);
        },
      );
    },
  );
}
