import 'src/shared/export/app_export.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await setupDependencyInjector();

  runApp(App());
}
