import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

class SupabaseRealtimeImpl implements RealtimeManager<SupabaseRealtimeDTO> {
  final SupabaseClient _client;
  RealtimeChannel? _channel;

  SupabaseRealtimeImpl({required SupabaseClient client}) : _client = client;

  @override
  Stream<Map<String, dynamic>> subscribe({
    required SupabaseRealtimeDTO dto,
  }) {
    final controller = StreamController<Map<String, dynamic>>();

    _channel = _client
        .channel(dto.channelName)
        .onPostgresChanges(
          event: dto.event,
          schema: dto.schema,
          table: dto.table,
          callback: (payload) {
            if (payload.newRecord.isNotEmpty) {
              controller.add(payload.newRecord);
            }
          },
        )
        .subscribe();

    return controller.stream;
  }

  @override
  Future<void> disconnect() {
    _channel?.unsubscribe();
    return Future.value();
  }
}
