import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class PanelBoardSmScreen extends StatelessWidget {
  const PanelBoardSmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSimple(),
      drawer: AppDrawer(),
      body: PanelBoardSmBody(),
    );
  }
}
