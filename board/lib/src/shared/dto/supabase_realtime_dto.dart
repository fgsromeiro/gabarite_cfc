import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

class SupabaseRealtimeDTO extends DTO {
  final String channelName;
  final PostgresChangeEvent event;
  final String schema;

  SupabaseRealtimeDTO({
    required super.table,
    required this.channelName,
    required this.event,
    this.schema = 'public',
  });
}
