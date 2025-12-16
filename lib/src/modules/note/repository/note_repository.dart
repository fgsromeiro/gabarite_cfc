import '../../../shared/export/app_export.dart';

abstract class NoteRepository {
  Future<List<TBL0001>> findAllNotes();
  Future<void> update(TBL0001 model);
}

class NoteRepositoryImpl implements NoteRepository {
  final DataManager dataManager;
  final NetworkVerifier networkVerifier;

  NoteRepositoryImpl({
    required this.dataManager,
    required this.networkVerifier,
  });

  @override
  Future<List<TBL0001>> findAllNotes() async {
    try {
      await networkVerifier.verifyConnection();

      final result = await dataManager.findAll(
        dto: SupabaseDTO(
          column: '',
          data: {},
          value: '',
          table: SupabaseUtils.kTBL0001,
        ),
      );

      return List.from(result.map((e) => TBL0001.fromMap(e)).toList()..sort((a, b) => a.title.compareTo(b.title)));
    } on CustomException {
      rethrow;
    }
  }

  @override
  Future<void> update(TBL0001 model) async {
    try {
      await networkVerifier.verifyConnection();

      await dataManager.update(
        dto: SupabaseDTO(value: model.id, table: SupabaseUtils.kTBL0001, data: model.toMap(), column: 'id'),
      );

      return;
    } on CustomException {
      rethrow;
    }
  }
}
