import 'package:flutter/material.dart';
import 'package:gabarite_board_cfc/src/ini/app.dart';
import 'package:gabarite_board_cfc/src/shared/di/dependency_injector.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.setupDependencyInjector();

  runApp(const App());
}
