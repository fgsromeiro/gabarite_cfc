import 'dart:developer';

import 'package:gabarite_cfc/src/shared/export/app_export.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSupabaseImpl implements AuthManager<AuthManagerDTO> {
  final SupabaseClient _client;

  AuthSupabaseImpl({
    required SupabaseClient client,
  }) : _client = client;

  @override
  Map<String, dynamic> currentUser() {
    final user = _client.auth.currentUser;

    if (user == null) {
      throw ErrorAuthSupabaseException(message: StringConstants.getString(3));
    } else {
      return user.toJson();
    }
  }

  @override
  Future<void> logOut() async {
    try {
      return await _client.auth.signOut();
    } catch (e) {
      log('MESSAGE -> $e');
      throw ErrorAuthSupabaseException();
    }
  }

  @override
  Future<Map<String, dynamic>> signIn({required AuthManagerDTO dto}) async {
    try {
      final result = await _client.auth.signInWithPassword(
        email: dto.email,
        password: dto.password,
      );
      return result.user!.toJson();
    } catch (e) {
      log('MESSAGE -> $e');
      throw ErrorAuthSupabaseException();
    }
  }

  @override
  Future<Map<String, dynamic>> signUp({required AuthManagerDTO dto}) async {
    try {
      final response = await _client.auth.signUp(
        email: dto.email,
        password: dto.password,
        data: {
          'name': dto.name,
        },
      );

      return response.user!.toJson();
    } catch (e) {
      log('MESSAGE -> $e');
      throw ErrorAuthSupabaseException();
    }
  }
}
