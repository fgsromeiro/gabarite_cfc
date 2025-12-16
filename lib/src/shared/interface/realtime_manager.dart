import 'package:flutter/foundation.dart';

@immutable
abstract class RealtimeManager<T> {
  Stream<Map<String, dynamic>> listen({required T dto});
  Future<void> disconnect();
}
