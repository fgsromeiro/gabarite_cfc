import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

class PanelTemplateTitleLeft extends StatelessWidget {
  const PanelTemplateTitleLeft({
    super.key,
    required this.backgroundColor,
    required this.title,
  });

  final Color backgroundColor;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.sz.width * 0.030,
      height: context.sz.height * 0.20,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          bottomLeft: Radius.circular(20),
        ),
      ),
      child: Center(
        child: RotatedBox(
          quarterTurns: 3,
          child: Text(
            title,
            style: context.theme.textTheme.headlineLarge!.copyWith(
              color: context.colorScheme.onTertiary,
              fontWeight: FontWeight.bold,
              fontFamily: AppFonts.stem,
            ),
          ),
        ),
      ),
    );
  }
}
