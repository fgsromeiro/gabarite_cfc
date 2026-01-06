

import '../../shared/export/app_export.dart';

class AppButton extends StatelessWidget {
  AppButton({
    super.key,
    required this.title,
    required this.onPressed,
    this.backgroundColor = AppColors.background,
    this.borderColor = Colors.transparent,
    this.titleColor = AppColors.white,
    this.isLoading = false,
    this.icon,
  });

  final String title;
  Color backgroundColor;
  Color borderColor;
  Color titleColor;
  bool isLoading;
  VoidCallback onPressed;
  IconData? icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: isLoading ? 150 : null,
      height: context.sz.height * 0.075,
      child: Opacity(
        opacity: isLoading ? 0.8 : 1,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor,
            shape: RoundedRectangleBorder(
              side: BorderSide(
                color: borderColor,
              ),
              borderRadius: BorderRadius.circular(
                AppRadius.md,
              ),
            ),
          ),
          onPressed: isLoading ? () {} : onPressed,
          child: isLoading
              ? Center(
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      color: AppColors.white,
                    ),
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppSpacing.med,
                  children: [
                    Text(
                      title.toUpperCase(),
                      style:
                          context.theme.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold, color: titleColor),
                    ),
                    if (icon != null)
                      Icon(
                        icon,
                        color: titleColor,
                      ),
                  ],
                ),
        ),
      ),
    );
  }
}
