import '../../../shared/export/app_export.dart';

enum TypeNote { typeOne, typeTwo, typeTree, typeFour }

extension TypeNoteX on TypeNote {
  bool get isLeft => [TypeNote.typeOne, TypeNote.typeTree].contains(this);
  bool get isRigth => [TypeNote.typeTwo, TypeNote.typeFour].contains(this);
}

class Question extends Equatable {
  final String idQuestionBase;
  final String id;
  final String title;
  final String alternative;
  final int index;
  final bool visible;
  final String idNote;
  final String teacher;
  final String enunciated;
  final String textAlternative;

  const Question({
    required this.idQuestionBase,
    required this.id,
    required this.title,
    required this.alternative,
    required this.index,
    required this.visible,
    required this.idNote,
    required this.enunciated,
    required this.teacher,
    required this.textAlternative,
  });

  factory Question.instance() => Question(
        idQuestionBase: '',
        id: '',
        title: '',
        alternative: '',
        index: 0,
        visible: false,
        idNote: '',
        enunciated: '',
        teacher: '',
        textAlternative: '',
      );

  factory Question.fromMap(Map<String, dynamic> map) {
    return Question(
      idQuestionBase: map['idQuestionBase'] != null ? map['idQuestionBase'] as String : '',
      id: map['id'] as String,
      title: map['title'] as String,
      alternative: map['alternative'] != null ? map['alternative'] as String : '',
      index: map['index'] as int,
      visible: map['visible'] != null ? map['visible'] as bool : false,
      idNote: map['idNote'] != null ? map['idNote'] as String : '',
      enunciated: map['enunciated'] != null ? map['enunciated'] as String : '',
      teacher: map['teacher'] != null ? map['teacher'] as String : '',
      textAlternative: map['textAlternative'] != null ? map['textAlternative'] as String : '',
    );
  }

  Question copyWith({
    String? idQuestionBase,
    String? id,
    String? title,
    String? alternative,
    int? index,
    bool? visible,
    String? idNote,
    String? enunciated,
    String? teacher,
    String? textAlternative,
  }) {
    return Question(
      idQuestionBase: idQuestionBase ?? this.idQuestionBase,
      id: id ?? this.id,
      title: title ?? this.title,
      alternative: alternative ?? this.alternative,
      index: index ?? this.index,
      visible: visible ?? this.visible,
      idNote: idNote ?? this.idNote,
      enunciated: enunciated ?? this.enunciated,
      teacher: teacher ?? this.teacher,
      textAlternative: textAlternative ?? this.textAlternative,
    );
  }

  @override
  List<Object> get props =>
      [idQuestionBase, id, title, alternative, index, visible, idNote, teacher, enunciated, textAlternative];
}
