import 'package:gabarite_cfc/src/modules/link/view/widgets/fromPanelLinkSmScreen/panel_link_sm_body.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

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
