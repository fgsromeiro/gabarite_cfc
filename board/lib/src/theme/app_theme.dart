import 'package:flutter/material.dart';
import 'package:gabarite_board_cfc/src/theme/app_color_scheme.dart';
import 'package:gabarite_board_cfc/src/theme/app_colors.dart';
import 'package:gabarite_board_cfc/src/theme/app_fonts.dart';
import 'package:gabarite_board_cfc/src/theme/app_text_style.dart';

class AppTheme {
  static ThemeData get ligth => ThemeData(
        scaffoldBackgroundColor: AppColors.background,
        appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(color: AppColors.secondary),
        ),
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
