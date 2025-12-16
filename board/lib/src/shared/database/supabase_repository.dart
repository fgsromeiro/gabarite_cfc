// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:gabarite_board_cfc/src/shared/error/custom_exception.dart';
import 'package:gabarite_board_cfc/src/shared/extension/object_extension.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract class SupabaseRepository {
  Future<List<Map<String, dynamic>>> findAll({required String table, String? column, String? id});
  Stream<Map<String, dynamic>> initializeRealtime({required String table, required String channelName});
  void dispose();
}

class SupabaseRepositoryImpl implements SupabaseRepository {
  final SupabaseClient _client;
  RealtimeChannel? _channel;

  SupabaseRepositoryImpl({
    required SupabaseClient client,
  }) : _client = client;

  @override
  Stream<Map<String, dynamic>> initializeRealtime({
    required String table,
    required String channelName,
  }) {
    final controller = StreamController<Map<String, dynamic>>();

    _channel = _client
        .channel(channelName)
        .onPostgresChanges(
          event: PostgresChangeEvent.update,
          schema: 'public',
          table: table,
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
  void dispose() {
    _channel?.unsubscribe();
  }

  @override
  Future<List<Map<String, dynamic>>> findAll({required String table, String? column, String? id}) async {
    try {
      if (column.isNull && id.isNull) {
        return await _client.from(table).select();
      }
      return await _client.from(table).select().eq(column!, id!);
    } catch (e) {
      throw ErrorSupabaseException(e.toString());
    }
  }
}
