import '../../shared/export/app_export.dart';

class AppSwitchButton extends StatelessWidget {
  const AppSwitchButton({
    super.key,
    required this.active,
    required this.onChanged,
  });

  final bool active;
  final void Function(bool value) onChanged;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: active,
      onChanged: onChanged,
      activeColor: context.colorScheme.primary,
      activeTrackColor: context.colorScheme.primary,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      trackOutlineWidth: WidgetStatePropertyAll(2),
      trackColor: WidgetStatePropertyAll(
          active ? context.colorScheme.primary.withValues(alpha: 0.2) : context.colorScheme.surface),
      trackOutlineColor: WidgetStatePropertyAll(
        active ? context.colorScheme.primary : context.colorScheme.onSecondaryFixedVariant,
      ),
    );
  }
}
