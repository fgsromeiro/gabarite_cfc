import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class PanelBoardBodyLoading extends StatelessWidget {
  const PanelBoardBodyLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.only(top: AppInsets.sm),
        child: Column(
          spacing: AppSpacing.sm,
          children: [
            ContainerPlaceholder(
              height: 250,
              width: double.infinity,
            ),
          ],
        ),
      ),
    );
  }
}
