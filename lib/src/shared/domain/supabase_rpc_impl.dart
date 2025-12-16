import 'dart:developer';

import 'package:gabarite_cfc/src/shared/export/app_export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseRpcImpl implements FunctionDatabase {
  final SupabaseClient _client;

  SupabaseRpcImpl({
    required SupabaseClient client,
  }) : _client = client;

  @override
  Future<void> call({
    required String fn,
    required Map<String, dynamic> constrains,
  }) async {
    try {
      await _client.rpc(fn, params: constrains);
      return;
    } catch (e) {
      log('MESSAGE -> $e');
      throw ErrorSupabaseException();
    }
  }
}
