import 'package:correcao_cfc/src/shared/export/app_export.dart';

class AuthScreen extends StatelessWidget {
  const AuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: context.colorScheme.surface,
        body: AuthBody(),
      ),
    );
  }
}
