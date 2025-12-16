import '../export/app_export.dart';

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

  static List<TBL0003> filterList({
    required int typeNote,
    required List<TBL0003> questions,
  }) {
    switch (typeNote) {
      case 1:
        return questions
            .where(
              (q) => q.idNote == 'd92a6b1b-2c09-44fe-a1e9-0bf2de159867',
            )
            .toList()
          ..sort(
            (a, b) => a.index.compareTo(b.index),
          );
      case 2:
        return questions
            .where(
              (q) => q.idNote == 'f6637be8-7582-43ce-84c5-0a6d0e819227',
            )
            .toList()
          ..sort(
            (a, b) => a.index.compareTo(b.index),
          );
      case 3:
        return questions
            .where(
              (q) => q.idNote == '7144b06a-7d56-4083-8422-5cbb18209369',
            )
            .toList()
          ..sort(
            (a, b) => a.index.compareTo(b.index),
          );
      case 4:
        return questions
            .where(
              (q) => q.idNote == '9e90ac85-31c3-4b82-831a-6d5a2c0afe3f',
            )
            .toList()
          ..sort(
            (a, b) => a.index.compareTo(b.index),
          );
      default:
        return [];
    }
  }
}
