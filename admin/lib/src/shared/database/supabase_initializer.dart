import 'package:gabarite_cfc/src/shared/utils/env.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseInitializer {
  SupabaseInitializer._();

  static Future<SupabaseClient> create() async {
    await Supabase.initialize(
      url: Env.urlSupabase,
      anonKey: Env.apiKey,
      debug: true,
    );

    return Supabase.instance.client;
  }
}
