class FunctionLinkDTO {
  final String id;
  final String? idQuestionbase;
  final String? enunciated;
  final String? alternative;
  final String? textAlternative;
  final bool? visible;

  FunctionLinkDTO({
    required this.id,
    this.visible,
    this.idQuestionbase,
    this.enunciated,
    this.alternative,
    this.textAlternative,
  });

  factory FunctionLinkDTO.instance() => FunctionLinkDTO(id: '');

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'idQuestionReference': idQuestionbase,
      'enunciated': enunciated,
      'alternative': alternative,
      'textAlternative': textAlternative,
      'visible': visible
    };
  }

  FunctionLinkDTO copyWith({
    String? id,
    String? idquestionbase,
    String? enunciated,
    String? alternative,
    String? textAlternative,
    bool? visible,
  }) {
    return FunctionLinkDTO(
      id: id ?? this.id,
      idQuestionbase: idquestionbase ?? idQuestionbase,
      enunciated: enunciated ?? this.enunciated,
      alternative: alternative ?? this.alternative,
      textAlternative: textAlternative ?? this.textAlternative,
      visible: visible ?? this.visible,
    );
  }
}
