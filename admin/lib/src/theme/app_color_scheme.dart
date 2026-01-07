import '../shared/export/app_export.dart';

class AppColorSchema {
  static ColorScheme get ligth => ColorScheme(
        primary: AppColors.primary,
        primaryFixed: AppColors.primaryFixed,
        secondary: AppColors.secondary,
        surface: AppColors.background,
        error: const Color.fromARGB(255, 209, 57, 57),
        onError: AppColors.errorLigth,
        onPrimary: AppColors.success,
        outline: AppColors.successLigth,
        onPrimaryFixed: AppColors.black,
        onTertiary: AppColors.white,
        onInverseSurface: AppColors.neutralDark,
        inversePrimary: AppColors.neutralBackground,
        onPrimaryContainer: AppColors.cardBackground,
        onPrimaryFixedVariant: AppColors.cardBackgroundTotal,
        primaryContainer: AppColors.modalBackground,
        outlineVariant: AppColors.progressBarBackground,
        onSecondary: AppColors.progressBarBorder,
        onSurface: AppColors.orangeDark,
        onTertiaryFixed: AppColors.formFieldBackground,
        scrim: AppColors.formHint,
        onTertiaryContainer: AppColors.blue100,
        onSecondaryContainer: AppColors.blue200,
        onSecondaryFixed: AppColors.blue300,
        onSecondaryFixedVariant: AppColors.blue400,
        secondaryContainer: AppColors.blue600,
        brightness: Brightness.light,
        inverseSurface: Colors.transparent,
        tertiaryContainer: AppColors.backgroundNeutral,
      );
}
