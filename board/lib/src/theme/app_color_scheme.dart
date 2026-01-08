import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

class AppColorSchema {
  static ColorScheme get ligth => ColorScheme(
        primary: AppColors.primary,
        primaryFixed: AppColors.primary,
        secondary: AppColors.primary,
        surface: AppColors.background,
        error: AppColors.error,
        onError: AppColors.errorLigth,
        onPrimaryFixed: AppColors.primary,
        onTertiary: AppColors.white,
        onSecondary: AppColors.primary,
        onSurface: AppColors.primary,
        brightness: Brightness.light,
        inverseSurface: Colors.transparent,
        onPrimary: Colors.transparent,
        scrim: AppColors.scrim,
      );
}
