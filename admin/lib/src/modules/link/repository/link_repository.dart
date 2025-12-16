import 'package:gabarite_cfc/src/shared/export/app_export.dart';

abstract class LinkRepository {
  Future<List<TBL0002>> findQuestionsByNote(String id);
  Future<void> link(FunctionLinkDTO dto);
  Future<void> removeLink(FunctionLinkDTO dto);
}

class LinkRepositoryImpl implements LinkRepository {
  final DataManager dataManager;
  final NetworkVerifier networkVerifier;

  LinkRepositoryImpl({required this.dataManager, required this.networkVerifier});

  @override
  Future<List<TBL0002>> findQuestionsByNote(String id) async {
    try {
      await networkVerifier.verifyConnection();

      final result = await dataManager.findAll(
        dto: SupabaseDTO(
          value: id,
          table: SupabaseUtils.kTBL0002,
          data: {},
          column: 'idNote',
        ),
      );

      return List.from(result.map((e) => TBL0002.fromMap(e)).toList())
        ..sort(
          (a, b) => a.index.compareTo(b.index),
        );
    } on CustomException {
      rethrow;
    }
  }

  @override
  Future<void> link(FunctionLinkDTO dto) async {
    try {
      await networkVerifier.verifyConnection();

      await dataManager.update(
        dto: SupabaseDTO(
          value: dto.id,
          table: SupabaseUtils.kTBL0002,
          data: dto.toMap(),
          column: 'id',
        ),
      );

      return;
    } on CustomException {
      rethrow;
    }
  }

  @override
  Future<void> removeLink(FunctionLinkDTO dto) async {
    try {
      await networkVerifier.verifyConnection();

      await dataManager.update(
        dto: SupabaseDTO(
          value: dto.id,
          table: SupabaseUtils.kTBL0002,
          data: dto.toMap(),
          column: 'id',
        ),
      );

      return;
    } on CustomException {
      rethrow;
    }
  }
}
