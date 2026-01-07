import '../shared/export/app_export.dart';

class AppTheme {
  static ThemeData get ligth => ThemeData(
      scaffoldBackgroundColor: AppColors.background,
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: AppColors.secondary),
      ),
      fontFamily: AppFonts.robotoLight,
      colorScheme: AppColorSchema.ligth,
      datePickerTheme: DatePickerThemeData(
        todayBackgroundColor: WidgetStatePropertyAll(AppColors.secondary),
        todayBorder: BorderSide(style: BorderStyle.none),
        dividerColor: AppColors.secondary,
        backgroundColor: AppColors.white,
        headerForegroundColor: AppColors.white,
        headerBackgroundColor: AppColors.primary,
        weekdayStyle: TextStyle(
          color: AppColors.primary,
        ),
        headerHeadlineStyle: AppTextStyle.h2,
      ),
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
      inputDecorationTheme: InputDecorationTheme(
        hintStyle: AppTextStyle.titleMedium.copyWith(
          color: AppColors.blue400,
          fontFamily: AppFonts.robotoLight,
        ),
        errorStyle: AppTextStyle.caption.copyWith(
          color: AppColors.errorPrimary,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(
            color: AppColors.cardBackgroundTotal,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(
            color: AppColors.blue400,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(
            color: AppColors.secondary,
            width: 2,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(
            color: AppColors.error,
            width: 1,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppRadius.md),
          borderSide: BorderSide(
            color: AppColors.error,
            width: 1,
          ),
        ),
      ),
      iconTheme: IconThemeData(
        size: AppIconSizes.iconMd,
        color: AppColors.cardBackgroundTotal,
      ),
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: AppColors.secondary,
        selectionColor: AppColors.secondary,
        selectionHandleColor: AppColors.secondary,
      ),
      bottomSheetTheme: BottomSheetThemeData(
        clipBehavior: Clip.antiAlias,
        modalBackgroundColor: AppColors.background.withBlue(30),
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
      ),
      switchTheme: SwitchThemeData(
          trackColor: WidgetStatePropertyAll(AppColors.cardBackground),
          trackOutlineColor: WidgetStatePropertyAll(AppColors.cardBackgroundTotal),
          thumbColor: WidgetStatePropertyAll(AppColors.cardBackgroundTotal)),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          padding: WidgetStatePropertyAll(
            EdgeInsets.symmetric(
              vertical: AppInsets.lg,
              horizontal: AppInsets.lg,
            ),
          ),
          elevation: WidgetStatePropertyAll(2),
          textStyle: WidgetStatePropertyAll(AppTextStyle.titleSmall),
          backgroundColor: WidgetStatePropertyAll(AppColors.primary),
          foregroundColor: WidgetStatePropertyAll(AppColors.white),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          elevation: WidgetStatePropertyAll(0),
          textStyle: WidgetStatePropertyAll(AppTextStyle.titleSmall),
          foregroundColor: WidgetStatePropertyAll(AppColors.white),
          overlayColor: WidgetStatePropertyAll(AppColors.transparent),
          shadowColor: WidgetStatePropertyAll(AppColors.transparent),
        ),
      ),
      progressIndicatorTheme: ProgressIndicatorThemeData(color: AppColors.white),
      checkboxTheme: CheckboxThemeData(
        checkColor: WidgetStatePropertyAll(
          AppColors.white,
        ),
        side: BorderSide(
          color: AppColors.formHint,
          width: 1.5,
        ),
      ));
}
