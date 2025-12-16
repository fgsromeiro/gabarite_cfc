import 'package:correcao_cfc/src/shared/export/app_export.dart';

class TBL0002 extends TBL0003 {
  final String idQuestionBase;

  const TBL0002({
    required this.idQuestionBase,
    required super.id,
    required super.title,
    required super.alternative,
    required super.index,
    required super.visible,
    required super.idNote,
    required super.enunciated,
    required super.teacher,
    required super.textAlternative,
  });

  bool get isEmpty => idQuestionBase.isEmpty;

  factory TBL0002.instance() => TBL0002(
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

  @override
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idQuestionBase': idQuestionBase,
      'id': id,
      'alternative': alternative,
      'visible': visible,
      'idNote': idNote,
      'enunciated': enunciated,
      'teacher': teacher,
      'textAlternative': textAlternative,
    };
  }

  factory TBL0002.fromMap(Map<String, dynamic> map) {
    return TBL0002(
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

  @override
  TBL0002 copyWith({
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
    return TBL0002(
      idQuestionBase: idQuestionBase ?? '',
      id: id ?? this.id,
      title: title ?? this.title,
      alternative: alternative ?? '',
      index: index ?? this.index,
      visible: visible ?? this.visible,
      idNote: idNote ?? this.idNote,
      enunciated: enunciated ?? '',
      teacher: teacher ?? this.teacher,
      textAlternative: textAlternative ?? '',
    );
  }
}
