import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

class AppTheme {
  static ThemeData get ligth => ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        fontFamily: AppFonts.stem,
        colorScheme: AppColorSchema.ligth,
        textTheme: TextTheme(
          headlineLarge: AppTextStyle.h1,
          headlineMedium: AppTextStyle.h2,
          headlineSmall: AppTextStyle.h3,
          titleLarge: AppTextStyle.titleLarge,
          titleMedium: AppTextStyle.titleMedium,
          titleSmall: AppTextStyle.titleSmall,
          bodyLarge: AppTextStyle.bodyLarge,
          bodyMedium: AppTextStyle.bodyMedium,
          bodySmall: AppTextStyle.bodySmall,
          labelMedium: AppTextStyle.caption,
        ),
      );
}
