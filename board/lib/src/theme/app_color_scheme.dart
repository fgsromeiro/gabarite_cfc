import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

class AppColorSchema {
  static ColorScheme get ligth => ColorScheme(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.tertiary,
        outline: AppColors.quartenary,
        surface: AppColors.background,
        error: AppColors.error,
        onError: AppColors.errorLigth,
        onPrimaryFixed: AppColors.black,
        onTertiary: AppColors.white,
        onSecondary: AppColors.black,
        onSurface: AppColors.black,
        brightness: Brightness.light,
        inverseSurface: Colors.transparent,
        onPrimary: Colors.transparent,
        scrim: AppColors.scrim,
      );
}
