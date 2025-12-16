import 'package:correcao_cfc/src/modules/visibility/view/widgets/visibility_header_content_sm.dart';
import 'package:correcao_cfc/src/ui/appBar/app_bar_simple.dart';
import 'package:correcao_cfc/src/ui/drawer/app_drawer.dart';

import '../../../../shared/export/app_export.dart';

class VisibilityBoardSmScreen extends StatelessWidget {
  const VisibilityBoardSmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSimple(),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(AppInsets.lg),
        margin: EdgeInsets.only(
          bottom: AppInsets.sm,
          left: AppInsets.sm,
          right: AppInsets.sm,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: context.colorScheme.onSecondaryFixedVariant,
          ),
        ),
        child: Column(
          spacing: AppSpacing.med,
          children: [
            VisibilityHeaderContentSm(),
            Expanded(child: VisibilityBody()),
          ],
        ),
      ),
    );
  }
}
