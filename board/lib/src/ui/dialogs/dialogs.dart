import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

class Dialogs {
  static Future<T?> showDialogAnimated<T>(
    BuildContext context, {
    required Widget dialog,
    bool barrierDismissible = true,
  }) async {
    final result = await showGeneralDialog<T>(
      barrierDismissible: barrierDismissible,
      barrierLabel: 'dismiss',
      context: context,
      barrierColor: Colors.black54,
      transitionDuration: Duration(milliseconds: 600),
      transitionBuilder: (_, a1, a2, child) {
        return ScaleTransition(
          scale: CurvedAnimation(
            parent: a1,
            curve: Curves.elasticOut,
            reverseCurve: Curves.easeInOutExpo,
          ),
          child: dialog,
        );
      },
      pageBuilder: (BuildContext context, anim, child) => SizedBox.shrink(),
    );

    return result;
  }

  static Future<bool> showDialogAction({
    required BuildContext context,
    required String title,
    required String description,
    required String titleAction,
    required VoidCallback onPressed,
  }) async {
    bool? isAction;

    isAction = await showDialog<bool>(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          backgroundColor: Colors.transparent,
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: context.colorScheme.surface,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: context.colorScheme.primary,
                  ),
                ),
                width: context.sz.width * 0.3,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: AppSpacing.med,
                  children: [
                    Text(
                      title,
                      style: context.theme.textTheme.headlineMedium!.copyWith(
                        color: context.colorScheme.onTertiary,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      description,
                      textAlign: TextAlign.start,
                      style: context.theme.textTheme.headlineSmall!.copyWith(
                        color: context.colorScheme.scrim,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.end,
                      spacing: AppSpacing.sm,
                      children: [
                        AppButton(
                          title: 'Fechar',
                          backgroundColor: context.colorScheme.surface,
                          titleColor: context.colorScheme.onTertiary,
                          borderColor: context.colorScheme.onTertiary,
                          onPressed: () {
                            Navigator.pop(context, false);
                          },
                        ),
                        AppButton(
                          title: titleAction,
                          backgroundColor: context.colorScheme.tertiary,
                          titleColor: context.colorScheme.surface,
                          borderColor: context.colorScheme.tertiary,
                          onPressed: () {
                            onPressed();
                            Navigator.pop(context, false);
                          },
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );

    return isAction ?? false;
  }
}
