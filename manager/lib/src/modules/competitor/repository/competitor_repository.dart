import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../shared/export/app_export.dart';

abstract class CompetitorRepository {
  Future<List<TBL0006>> findAllByNote(String idNote);
  Future<void> updateRow(TBL0006 competitor);
  Stream<TBL0006> listenCompetitor();
  Future<void> dispose();
}

class CompetitorRepositoryImpl implements CompetitorRepository {
  final DataManager dataManager;
  final RealtimeManager realtimeManager;
  final NetworkVerifier networkVerifier;

  CompetitorRepositoryImpl({
    required this.dataManager,
    required this.realtimeManager,
    required this.networkVerifier,
  });

  @override
  Stream<TBL0006> listenCompetitor() {
    return realtimeManager
        .listen(
      dto: SupabaseRealtimeDTO(
        table: SupabaseUtils.kTBL0006,
        channelName: 'competitors_changes',
        event: PostgresChangeEvent.update,
        schema: 'public',
      ),
    )
        .map((data) {
      return TBL0006.fromMap(data);
    });
  }

  @override
  Future<void> dispose() async {
    return realtimeManager.disconnect();
  }

  @override
  Future<List<TBL0006>> findAllByNote(String idNote) async {
    try {
      await networkVerifier.verifyConnection();

      final result = await dataManager.findAll(
        dto: SupabaseDTO(
          table: SupabaseUtils.kTBL0006,
          data: {},
          column: 'idNote',
          value: idNote,
        ),
      );

      return List.from(result.map((e) => TBL0006.fromMap(e)).toList())
        ..sort(
          (a, b) => a.index.compareTo(b.index),
        );
    } on CustomException {
      rethrow;
    }
  }

  @override
  Future<void> updateRow(TBL0006 competitor) async {
    try {
      await networkVerifier.verifyConnection();

      await dataManager.update(
          dto: SupabaseDTO(
        table: SupabaseUtils.kTBL0006,
        data: competitor.toMap(),
        column: 'id',
        value: competitor.id,
      ));

      return;
    } on CustomException {
      rethrow;
    }
  }
}
