import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

mixin PanelMixin {
  String buildAlternative(String value) {
    if (value.isEmpty) return value;

    if (value == 'A/R' || value == 'B/R' || value == 'C/R' || value == 'D/R') {
      return value;
    }

    return value[0];
  }

  Color buildAlternativeColor(String value) {
    if (value == 'ANULADO' ||
        value == 'RECURSO' ||
        value == 'A/R' ||
        value == 'B/R' ||
        value == 'C/R' ||
        value == 'D/R') {
      return AppColors.error;
    }

    return AppColors.black;
  }

  Color buildAlternativeBorderColor(TypeNote type) {
    return AppColors.primary;
  }

  Color buildAlternativeBackgroundColor(String value) {
    if (value == 'ANULADO' ||
        value == 'RECURSO' ||
        value == 'A/R' ||
        value == 'B/R' ||
        value == 'C/R' ||
        value == 'D/R') {
      return Color(0xffffc7ce);
    }

    return AppColors.white;
  }
}
