import 'package:gabarite_cfc/src/shared/export/app_export.dart';

abstract class BoardRepository {
  Future<List<TBL0003>> findAll();
  Future<void> update(TBL0003 question);
}

class BoardRepositoryImpl implements BoardRepository {
  final DataManager dataManager;
  final NetworkVerifier networkVerifier;

  BoardRepositoryImpl({required this.dataManager, required this.networkVerifier});

  @override
  Future<void> update(TBL0003 question) async {
    try {
      await networkVerifier.verifyConnection();

      await dataManager.update(
        dto: SupabaseDTO(
          value: question.id,
          table: SupabaseUtils.kTBL0003,
          data: question.toMap(),
          column: 'id',
        ),
      );

      return;
    } on CustomException {
      rethrow;
    }
  }

  @override
  Future<List<TBL0003>> findAll() async {
    try {
      await networkVerifier.verifyConnection();

      final result = await dataManager.findAll(
        dto: SupabaseDTO(
          table: SupabaseUtils.kTBL0003,
          data: {},
          value: StringConstants.empty,
          column: StringConstants.empty,
        ),
      );

      return List.from(
        result.map((e) => TBL0003.fromMap(e)).toList()
          ..sort(
            (a, b) => a.index.compareTo(b.index),
          ),
      );
    } on CustomException {
      rethrow;
    }
  }
}
