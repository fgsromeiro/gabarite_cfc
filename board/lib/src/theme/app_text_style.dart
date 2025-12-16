import 'package:flutter/material.dart';
import 'package:gabarite_board_cfc/src/theme/app_colors.dart';
import 'package:gabarite_board_cfc/src/theme/app_font_size.dart';
import 'package:gabarite_board_cfc/src/theme/app_fonts.dart';

class AppTextStyle {
  static TextStyle stem = TextStyle(
    color: AppColors.white,
    fontFamily: AppFonts.stem,
  );

  static TextStyle stemLigth = TextStyle(
    fontFamily: AppFonts.stemLight,
    color: AppColors.white,
    height: 1,
  );

  static TextStyle get h1 => stem.copyWith(
        fontSize: AppFontSize.s32,
        fontWeight: FontWeight.normal,
        letterSpacing: -1,
        height: 1.17,
      );

  static TextStyle get h2 => h1.copyWith(
        fontSize: AppFontSize.s22,
        letterSpacing: -.5,
        height: 1.16,
      );

  static TextStyle get h3 => h1.copyWith(
        fontSize: AppFontSize.s20,
        letterSpacing: -.05,
        height: 1.29,
      );

  static TextStyle get titleLarge => stem.copyWith(
        fontSize: AppFontSize.s20,
        height: 1.31,
      );
  static TextStyle get titleMedium => stem.copyWith(
        color: AppColors.white,
        fontSize: AppFontSize.s18,
      );
  static TextStyle get titleSmall => stem.copyWith(
        fontSize: AppFontSize.s14,
        height: 1.41,
      );

  static TextStyle get bodyLarge => stemLigth.copyWith(
        fontSize: AppFontSize.s16,
        // height: 1.41,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get bodyMedium => stemLigth.copyWith(
        fontSize: AppFontSize.s14,
        height: 1.41,
        fontWeight: FontWeight.normal,
      );
  static TextStyle get bodySmall => stemLigth.copyWith(
        fontSize: AppFontSize.s11,
        fontWeight: FontWeight.bold,
      );

  static TextStyle get caption => stem.copyWith(
        fontWeight: FontWeight.w500,
        fontSize: AppFontSize.s14,
        height: 0,
      );
}
