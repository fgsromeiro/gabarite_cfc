import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class PanelLink extends StatelessWidget {
  const PanelLink({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        PanelLinkHeader(),
        PanelLinkBody(),
      ],
    );
  }
}
