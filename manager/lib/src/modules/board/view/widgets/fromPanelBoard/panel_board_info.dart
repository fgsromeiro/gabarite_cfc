import '../../../../../shared/export/app_export.dart';

class PanelBoardInfo extends StatelessWidget {
  const PanelBoardInfo({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      spacing: AppInsets.xs,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: context.colorScheme.onSecondaryFixedVariant,
        ),
        Text(
          label,
          style: context.theme.textTheme.headlineMedium!.copyWith(
            color: context.colorScheme.onSecondaryFixedVariant,
          ),
        ),
        10.h,
        Container(
          padding: EdgeInsets.all(AppInsets.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: context.colorScheme.secondary,
            ),
          ),
          child: Text(
            value,
            style: context.theme.textTheme.headlineSmall!.copyWith(
              color: context.colorScheme.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
}
