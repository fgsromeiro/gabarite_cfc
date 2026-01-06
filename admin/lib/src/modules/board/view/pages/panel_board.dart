import 'package:gabarite_cfc/src/modules/board/view/widgets/fromPanelBoard/panel_board_body.dart';
import 'package:gabarite_cfc/src/modules/board/view/widgets/fromPanelBoard/panel_board_header.dart';

import '../../../../shared/export/app_export.dart';

class PanelBoard extends StatelessWidget {
  const PanelBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        PanelBoardHeader(),
        PanelBoardBody(),
      ],
    );
  }
}
