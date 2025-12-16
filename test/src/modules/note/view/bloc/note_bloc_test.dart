import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../../fixture_reader.dart';
import '../../../../../mocks/mocks.mocks.dart';

void main() {
  late MockApplicationGlobalMixin mockApplicationGlobalMixin;
  late MockNoteService mockNoteService;
  late NoteBloc bloc;
  late Map<String, dynamic> dataMap;
  late List<TBL0001> listOfNotes;
  late TBL0001 note;

  setUp(() {
    mockApplicationGlobalMixin = MockApplicationGlobalMixin();
    mockNoteService = MockNoteService();
    bloc = NoteBloc(service: mockNoteService);
    dataMap = fixture('list_of_notes.json');
    listOfNotes = (dataMap['notes'] as List).map((q) => TBL0001.fromMap(q as Map<String, dynamic>)).toList();
    note = listOfNotes.first;
  });

  tearDown(() {
    bloc.close();
    reset(mockNoteService);
    reset(mockApplicationGlobalMixin);
  });

  group('NoteBloc - Tests for the load() method', () {
    blocTest<NoteBloc, NoteState>(
      'should issue a new state with the list of notes by successfully carrying',
      setUp: () {
        when(mockApplicationGlobalMixin.getNoteReference(listOfNotes)).thenReturn(listOfNotes.first);
        when(mockNoteService.findAllNotes()).thenAnswer((_) async => listOfNotes);
      },
      build: () => bloc,
      act: (bloc) => bloc.fetchNotes(),
      expect: () => [
        NoteState.initial().copyWith(status: NoteStatus.loading),
        NoteState.initial().copyWith(
            status: NoteStatus.loaded,
            notes: listOfNotes,
            reference: mockApplicationGlobalMixin.getNoteReference(listOfNotes)),
      ],
      verify: (bloc) {
        verify(mockNoteService.findAllNotes()).called(1);
        expect(bloc.state.status, NoteStatus.loaded);
        expect(bloc.state.notes, listOfNotes);
        expect(bloc.state.reference, mockApplicationGlobalMixin.getNoteReference(listOfNotes));
      },
    );

    blocTest<NoteBloc, NoteState>(
      'should emit an error state when load() fails',
      setUp: () {
        when(mockNoteService.findAllNotes()).thenThrow(ErrorSupabaseException());
      },
      build: () => bloc,
      act: (bloc) => bloc.fetchNotes(),
      expect: () => [
        NoteState.initial().copyWith(status: NoteStatus.loading),
        NoteState.initial().copyWith(
          status: NoteStatus.error,
          message: ErrorSupabaseException().toString(),
        ),
      ],
      verify: (bloc) {
        verify(mockNoteService.findAllNotes()).called(1);
        expect(bloc.state.status, NoteStatus.error);
        expect(bloc.state.message, ErrorSupabaseException().toString());
      },
    );
    blocTest<NoteBloc, NoteState>(
      'should emit an error Connection state when load() fails ',
      setUp: () {
        when(mockNoteService.findAllNotes()).thenThrow(ConnectionInternetErrorException());
      },
      build: () => bloc,
      act: (bloc) => bloc.fetchNotes(),
      expect: () => [
        NoteState.initial().copyWith(status: NoteStatus.loading),
        NoteState.initial().copyWith(status: NoteStatus.error, message: ConnectionInternetErrorException().toString()),
      ],
      verify: (bloc) {
        verify(mockNoteService.findAllNotes()).called(1);
        expect(bloc.state.status, NoteStatus.error);
        expect(bloc.state.message, ConnectionInternetErrorException().toString());
      },
    );
  });
  group('NoteBloc - Tests for the update() method', () {
    blocTest<NoteBloc, NoteState>(
      'must issue [updating, updated] and synchronize the list of notes after success',
      setUp: () {
        when(mockNoteService.update(any)).thenAnswer((_) async => Future.value());

        when(mockNoteService.findAllNotes()).thenAnswer((_) async => listOfNotes);

        when(mockApplicationGlobalMixin.getNoteReference(listOfNotes)).thenReturn(listOfNotes.first);
      },
      build: () => bloc,
      act: (bloc) => bloc.updateNote(note),
      expect: () => [
        NoteState.initial().copyWith(status: NoteStatus.updating),
        NoteState.initial().copyWith(
          status: NoteStatus.updated,
          notes: listOfNotes,
          reference: mockApplicationGlobalMixin.getNoteReference(listOfNotes),
        ),
      ],
    );
    blocTest<NoteBloc, NoteState>(
      'must issue [updating, error] when updateNote() failures',
      setUp: () {
        when(mockNoteService.update(any)).thenThrow(ErrorSupabaseException());

        when(mockNoteService.findAllNotes()).thenAnswer((_) async => listOfNotes);

        when(mockApplicationGlobalMixin.getNoteReference(listOfNotes)).thenReturn(listOfNotes.first);
      },
      build: () => bloc,
      act: (bloc) => bloc.updateNote(note),
      expect: () => [
        NoteState.initial().copyWith(status: NoteStatus.updating),
        NoteState.initial().copyWith(
          status: NoteStatus.error,
          message: ErrorSupabaseException().toString(),
        ),
      ],
    );
  });
}
