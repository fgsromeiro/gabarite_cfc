import '../../../../../shared/export/app_export.dart';

class BoardPanelLabelCard extends StatelessWidget with ApplicationGlobalMixin {
  BoardPanelLabelCard({
    super.key,
    this.label,
    required this.value,
    required this.icon,
    this.color,
    this.isBorder = false,
  });

  final String? label;
  final String value;
  final IconData icon;
  final Color? color;
  bool isBorder;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppInsets.xs),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: isBorder ? Border.all(color: color ?? context.colorScheme.onSecondaryFixedVariant) : null,
      ),
      child: Flex(
        direction: Axis.horizontal,
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            color: color ?? context.colorScheme.onSecondaryFixedVariant,
          ),
          2.w,
          if (label.isNotNull)
            Text(
              label ?? '',
              style: context.theme.textTheme.headlineSmall!.copyWith(
                color: color ?? context.colorScheme.onSecondaryFixedVariant,
              ),
            ),
          5.w,
          Flexible(
            child: Text(
              value,
              style: context.theme.textTheme.headlineSmall!.copyWith(
                color: mapperColorAlternative(value),
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
