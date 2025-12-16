import 'package:gabarite_board_cfc/src/modules/panel/models/question.dart';

class Utils {
  static String? validateEmail(String? value) {
    const Pattern pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';

    final emailRegex = RegExp(
      pattern as String,
    );

    if (value != null && (emailRegex.hasMatch(value))) {
      return null;
    } else {
      return 'Por favor, informe um e-mail válido';
    }
  }

  static List<Question> filterList({
    required TypeNote typeNote,
    required List<Question> questions,
  }) {
    switch (typeNote) {
      case TypeNote.typeOne:
        return questions
            .where(
              (q) => q.idNote == '64abf5c1-e517-49d5-9777-b6094badd0b8',
            )
            .toList()
          ..sort(
            (a, b) => a.index.compareTo(b.index),
          );
      case TypeNote.typeTwo:
        return questions
            .where(
              (q) => q.idNote == 'acee70dc-f3fb-4c2d-a8f2-a9fa99908a14',
            )
            .toList()
          ..sort(
            (a, b) => a.index.compareTo(b.index),
          );
      case TypeNote.typeTree:
        return questions
            .where(
              (q) => q.idNote == 'cde17634-3e70-4941-83f5-557f5a652d77',
            )
            .toList()
          ..sort(
            (a, b) => a.index.compareTo(b.index),
          );
      case TypeNote.typeFour:
        return questions
            .where(
              (q) => q.idNote == 'c0b90015-17f8-4ca5-a61a-74280b0136f8',
            )
            .toList()
          ..sort(
            (a, b) => a.index.compareTo(b.index),
          );
    }
  }
}
