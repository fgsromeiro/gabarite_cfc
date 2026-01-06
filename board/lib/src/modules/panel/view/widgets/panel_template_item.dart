import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

class PanelTemplateItem extends StatelessWidget with PanelMixin {
  const PanelTemplateItem({
    super.key,
    required this.index,
    required this.alternative,
    required this.isVisible,
    required this.type,
  });

  final int index;
  final String alternative;
  final bool isVisible;
  final TypeNote type;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          index <= 9 ? '0$index' : '$index',
          style: context.theme.textTheme.titleMedium!.copyWith(
            color: context.colorScheme.onTertiary,
            fontWeight: FontWeight.bold,
            fontFamily: AppFonts.stemLight,
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.symmetric(horizontal: 5),
            padding: EdgeInsets.zero,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: isVisible ? buildAlternativeBackgroundColor(alternative) : context.colorScheme.onTertiary,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(
                color: buildAlternativeBorderColor(type),
              ),
            ),
            child: Text(
              alternative.isNotEmpty && isVisible ? buildAlternative(alternative) : '',
              style: context.theme.textTheme.headlineLarge!.copyWith(
                color: buildAlternativeColor(alternative),
                fontWeight: FontWeight.bold,
                fontFamily: AppFonts.stemLight,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }
}
