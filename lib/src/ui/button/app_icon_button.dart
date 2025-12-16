import '../../shared/export/app_export.dart';

class AppIconButton extends StatelessWidget {
  const AppIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    required this.tooltipMessage,
    this.color,
    this.backgroundColor,
    this.overlayColor,
    this.borderColor,
  });

  final Color? backgroundColor;
  final Color? overlayColor;
  final Color? borderColor;
  final Color? color;
  final IconData icon;
  final VoidCallback onPressed;
  final String tooltipMessage;

  @override
  Widget build(BuildContext context) {
    bool isHovering = false;
    return StatefulBuilder(
      builder: (context, setState) {
        return Tooltip(
          message: tooltipMessage,
          child: SizedBox(
            height: context.sz.height * 0.072,
            width: context.sz.width * 0.035,
            child: IconButton(
              onHover: (value) => setState(() => isHovering = value),
              style: context.theme.elevatedButtonTheme.style!.copyWith(
                padding: const WidgetStatePropertyAll(EdgeInsets.zero),
                backgroundColor: WidgetStatePropertyAll(isHovering ? overlayColor : backgroundColor),
                shape: WidgetStatePropertyAll(
                  CircleBorder(
                    side: BorderSide(
                      color: isHovering ? Colors.transparent : borderColor ?? Colors.transparent,
                    ),
                  ),
                ),
              ),
              onPressed: onPressed,
              icon: Icon(
                icon,
                color: isHovering ? backgroundColor : color,
              ),
            ),
          ),
        );
      },
    );
  }
}
