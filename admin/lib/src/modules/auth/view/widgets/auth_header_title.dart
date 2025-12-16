import '../../../../shared/export/app_export.dart';

class AuthHeaderTitle extends StatelessWidget {
  const AuthHeaderTitle({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        Text(
          title,
          style: context.theme.textTheme.headlineLarge!.copyWith(
            color: context.colorScheme.onTertiary,
            // fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          subtitle,
          style: context.theme.textTheme.titleMedium!.copyWith(color: context.colorScheme.outlineVariant),
        ),
      ],
    );
  }
}
