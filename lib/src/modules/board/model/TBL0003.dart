import 'package:gabarite_cfc/src/shared/export/app_export.dart';

enum FilterQuestion { all, answered, notAnswered }

class TBL0003 extends Question {
  final String teacher;

  const TBL0003({
    required super.id,
    required super.title,
    required super.alternative,
    required super.index,
    required super.visible,
    required super.idNote,
    required super.enunciated,
    required super.textAlternative,
    required this.teacher,
  });

  bool get isFilled =>
      enunciated.isNotEmpty && teacher.isNotEmpty && alternative.isNotEmpty && textAlternative.isNotEmpty;

  factory TBL0003.instance() => TBL0003(
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

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'alternative': alternative,
      'visible': visible,
      'idNote': idNote,
      'enunciated': enunciated,
      'teacher': teacher,
      'textAlternative': textAlternative,
    };
  }

  factory TBL0003.fromMap(Map<String, dynamic> map) {
    return TBL0003(
      id: map['id'] as String,
      title: map['title'] as String,
      alternative: map['alternative'] as String? ?? '',
      index: map['index'] as int,
      visible: map['visible'] as bool,
      idNote: map['idNote'] as String? ?? '',
      enunciated: map['enunciated'] as String? ?? '',
      teacher: map['teacher'] as String? ?? '',
      textAlternative: map['textAlternative'] as String? ?? '',
    );
  }

  TBL0003 copyWith({
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
    return TBL0003(
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
  List<Object> get props => [id, title, alternative, index, visible, idNote, enunciated, teacher, textAlternative];

  @override
  String toString() => title;
}
