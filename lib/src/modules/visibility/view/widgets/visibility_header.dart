import 'package:gabarite_cfc/src/modules/visibility/view/widgets/visibility_header_content_lg.dart';
import 'package:gabarite_cfc/src/modules/visibility/view/widgets/visibility_header_content_sm.dart';

import '../../../../shared/export/app_export.dart';

class VisibilityHeader extends StatelessWidget {
  const VisibilityHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (context.isMobile) {
      return VisibilityHeaderContentSm();
    } else {
      return VisibilityHeaderContentLg();
    }
  }
}
