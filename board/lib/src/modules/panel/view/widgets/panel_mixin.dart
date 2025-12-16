import 'dart:ui';

import 'package:gabarite_board_cfc/src/modules/panel/models/question.dart';
import 'package:gabarite_board_cfc/src/theme/app_colors.dart';

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
    if (type == TypeNote.typeTwo) return const Color.fromARGB(255, 42, 73, 104);
    if (type == TypeNote.typeTree) return const Color.fromARGB(255, 163, 123, 42);
    if (type == TypeNote.typeFour) return const Color.fromARGB(255, 91, 122, 91);

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
