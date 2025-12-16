import 'package:correcao_cfc/src/shared/export/app_export.dart';

class NoteBloc extends Cubit<NoteState> with ApplicationGlobalMixin {
  final NoteService service;

  NoteBloc({
    required this.service,
  }) : super(NoteState.initial());

  Future<void> fetchNotes() async {
    emit(state.copyWith(status: NoteStatus.loading));
    try {
      final notes = await service.findAllNotes();

      emit(state.copyWith(status: NoteStatus.loaded, notes: notes, reference: getNoteReference(notes)));

      return;
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.error, message: e.toString()));
      return;
    }
  }

  Future<void> updateNote(TBL0001 note) async {
    emit(state.copyWith(status: NoteStatus.updating));
    try {
      await service.update(note);
      final notesSync = await service.findAllNotes();

      emit(
        state.copyWith(
          status: NoteStatus.updated,
          notes: notesSync,
          reference: getNoteReference(notesSync),
        ),
      );

      return;
    } catch (e) {
      emit(state.copyWith(status: NoteStatus.error, message: e.toString()));
      return;
    }
  }
}
