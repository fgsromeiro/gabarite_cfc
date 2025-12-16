import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRealtimeImpl implements RealtimeManager<SupabaseRealtimeDTO> {
  final SupabaseClient _client;
  RealtimeChannel? _channel;

  SupabaseRealtimeImpl({required SupabaseClient client}) : _client = client;

  @override
  Stream<Map<String, dynamic>> listen({
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
