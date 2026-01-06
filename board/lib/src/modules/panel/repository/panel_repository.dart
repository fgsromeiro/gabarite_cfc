import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

abstract class PanelRepository {
  Future<List<Question>> findAllQuestions();
  Stream<Question> listenQuestion();
  Stream<bool> listenSettingDisplay();
  Future<void> dispose();
}

class PanelRepositoryImpl implements PanelRepository {
  final DataManager dataManager;
  final RealtimeManager realtimeManager;

  PanelRepositoryImpl({required this.dataManager, required this.realtimeManager});

  @override
  Future<List<Question>> findAllQuestions() async {
    try {
      final dto = SupabaseDTO(table: SupabaseUtils.kTBL0002, column: '', value: '', data: {});

      final result = await dataManager.findAll(dto: dto);

      return List.from(result.map((e) => Question.fromMap(e)).toList())
        ..sort(
          (a, b) => a.index.compareTo(b.index),
        );
    } on CustomException {
      rethrow;
    }
  }

  @override
  Stream<Question> listenQuestion() {
    try {
      final dto = SupabaseRealtimeDTO(
        table: SupabaseUtils.kTBL0002,
        schema: 'public',
        event: PostgresChangeEvent.update,
        channelName: 'public:TBL0002',
      );

      return realtimeManager.subscribe(dto: dto).map((data) => Question.fromMap(data));
    } on CustomException {
      rethrow;
    }
  }

  @override
  Future<void> dispose() async {
    return await realtimeManager.disconnect();
  }

  @override
  Stream<bool> listenSettingDisplay() {
    try {
      final dto = SupabaseRealtimeDTO(
        table: SupabaseUtils.kTBL0005,
        schema: 'public',
        event: PostgresChangeEvent.update,
        channelName: 'public:TBL0005',
      );

      return realtimeManager.subscribe(dto: dto).map((data) => data['showButton'] as bool);
    } on CustomException {
      rethrow;
    }
  }
}
