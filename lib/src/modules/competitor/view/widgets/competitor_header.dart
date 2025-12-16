import 'package:correcao_cfc/src/modules/competitor/view/widgets/competitor_header_content_lg.dart';
import 'package:correcao_cfc/src/modules/competitor/view/widgets/competitor_header_content_sm.dart';

import '../../../../shared/export/app_export.dart';

class CompetitorHeader extends StatelessWidget {
  const CompetitorHeader({super.key});

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return CompetitorHeaderContentSm();
    } else {
      return CompetitorHeaderContentLg();
    }
  }
}
