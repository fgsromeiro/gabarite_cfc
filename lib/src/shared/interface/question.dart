import 'package:gabarite_cfc/src/shared/export/app_export.dart';

abstract class Question extends Equatable {
  final String id;
  final String title;
  final String alternative;
  final int index;
  final bool visible;
  final String idNote;
  final String enunciated;
  final String textAlternative;

  const Question({
    required this.id,
    required this.title,
    required this.alternative,
    required this.index,
    required this.visible,
    required this.idNote,
    required this.enunciated,
    required this.textAlternative,
  });

  @override
  bool? get stringify => true;
}
