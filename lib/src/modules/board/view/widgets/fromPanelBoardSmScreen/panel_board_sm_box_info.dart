import 'package:correcao_cfc/src/shared/export/app_export.dart';

class PanelBoardSmBoxInfo extends StatelessWidget {
  const PanelBoardSmBoxInfo({super.key, required this.text, this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(
          color: color ?? context.colorScheme.secondary,
        ),
      ),
      child: Text(
        text,
        style: context.theme.textTheme.headlineSmall!.copyWith(
          color: color ?? context.colorScheme.secondary,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
