// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../shared/export/app_export.dart';

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    required this.isLoading,
    this.tooltipMessage,
    this.backgroundColor = AppColors.primary,
    this.borderColor = AppColors.primary,
    this.titleColor = AppColors.primaryFixed,
    this.icon,
    this.overlayColor = AppColors.secondary,
  });

  final String title;
  final String? tooltipMessage;
  final VoidCallback onPressed;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? borderColor;
  final Color? titleColor;
  final IconData? icon;
  final Color? overlayColor;

  @override
  Widget build(BuildContext context) {
    bool isHovering = false;
    return StatefulBuilder(
      builder: (context, setState) => SizedBox(
        width: isLoading ? 150 : null,
        child: Opacity(
          opacity: isLoading ? 0.8 : 1,
          child: Tooltip(
            message: tooltipMessage ?? '',
            child: ElevatedButton(
              onHover: (value) => setState(() => isHovering = value),
              style: context.theme.elevatedButtonTheme.style!.copyWith(
                backgroundColor: WidgetStatePropertyAll(isHovering ? overlayColor : backgroundColor),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    side: BorderSide(color: borderColor ?? Colors.transparent),
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                  ),
                ),
              ),
              onPressed: isLoading ? () {} : onPressed,
              child: AppConditionalWidget(
                condition: isLoading,
                firstChild: Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: AppCircularIndicator(color: isHovering ? backgroundColor : titleColor),
                  ),
                ),
                secondChild: Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppSpacing.med,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style: context.theme.textTheme.labelMedium!.copyWith(
                        fontWeight: FontWeight.bold,
                        color: titleColor,
                      ),
                    ),
                    if (icon != null)
                      Icon(
                        icon,
                        color: isHovering ? backgroundColor : titleColor,
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
