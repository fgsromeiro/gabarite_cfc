import '../../shared/export/app_export.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({super.key, required this.title, required this.description, this.spacing});

  final String title;
  final String description;
  final double? spacing;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      spacing: spacing ?? 0,
      children: [
        Text(
          title,
          style: context.theme.textTheme.headlineLarge!.copyWith(
            color: context.colorScheme.onTertiary,
          ),
        ),
        Text(
          description,
          style: context.theme.textTheme.headlineSmall!.copyWith(
            color: context.colorScheme.scrim,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
