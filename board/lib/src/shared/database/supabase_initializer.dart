import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseInitializer {
  SupabaseInitializer._();

  static Future<SupabaseClient> create() async {
    await Supabase.initialize(
      url: 'https://mpjuquwxwehyqpuquyql.supabase.co',
      anonKey: 'sb_publishable_D6tcHPNORMRLVKefH9gYqQ_wmcIq3ov',
      debug: true,
    );

    return Supabase.instance.client;
  }
}
