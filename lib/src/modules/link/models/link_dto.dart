import '../../../shared/export/app_export.dart';

class LinkDTO {
  final String idQuestion;
  final TBL0003 qBase;

  LinkDTO({
    required this.idQuestion,
    required this.qBase,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'idQuestion': idQuestion,
      'id': qBase.id,
      'alternative': qBase.alternative,
      'visible': qBase.visible,
      'idNote': qBase.idNote,
      'enunciated': qBase.enunciated,
      'teacher': qBase.teacher,
      'textAlternative': qBase.textAlternative,
    };
  }

  factory LinkDTO.fromMap(Map<String, dynamic> map) {
    return LinkDTO(
      idQuestion: map['idQuestion'] as String,
      qBase: TBL0003.fromMap(map['qBase'] as Map<String, dynamic>),
    );
  }
}
