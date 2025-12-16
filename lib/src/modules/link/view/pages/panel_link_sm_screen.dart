import 'package:correcao_cfc/src/modules/link/view/widgets/fromPanelLinkSmScreen/panel_link_sm_body.dart';
import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:correcao_cfc/src/ui/appBar/app_bar_simple.dart';
import 'package:correcao_cfc/src/ui/drawer/app_drawer.dart';

class PanelLinkSmScreen extends StatelessWidget {
  const PanelLinkSmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSimple(),
      drawer: AppDrawer(),
      body: PanelLinkSmBody(),
    );
  }
}
