import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class BoardPanelInfoStatus extends StatelessWidget with ApplicationGlobalMixin {
  const BoardPanelInfoStatus({
    super.key,
    required this.isFinished,
  });

  final bool isFinished;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(AppInsets.xs),
      decoration: BoxDecoration(
        color: isFinished ? context.colorScheme.onPrimary : context.colorScheme.onSecondaryFixedVariant,
        borderRadius: BorderRadius.circular(AppRadius.full),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: AppSpacing.xs,
        children: [
          Icon(
            isFinished ? Icons.check_circle_outlined : Icons.info_outline,
            color: context.colorScheme.onTertiary,
          ),
          Text(
            isFinished ? 'Respondida' : 'Pendente',
            style: context.theme.textTheme.headlineSmall!.copyWith(color: context.colorScheme.onTertiary),
          ),
        ],
      ),
    );
  }
}
