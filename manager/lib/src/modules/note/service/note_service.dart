import '../../../shared/export/app_export.dart';

abstract class NoteService {
  Future<List<TBL0001>> findAllNotes();
  Future<void> update(TBL0001 model);
}

class NoteServiceImpl implements NoteService {
  final NoteRepository repository;

  NoteServiceImpl({
    required this.repository,
  });

  @override
  Future<List<TBL0001>> findAllNotes() async {
    return repository.findAllNotes();
  }

  @override
  Future<void> update(TBL0001 model) async {
    return repository.update(model);
  }
}
