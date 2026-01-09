import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRealtimeDTO {
  final String table;
  final String channelName;
  final PostgresChangeEvent event;
  final String schema;

  SupabaseRealtimeDTO({
    required this.table,
    required this.channelName,
    required this.event,
    this.schema = 'public',
  });
}
