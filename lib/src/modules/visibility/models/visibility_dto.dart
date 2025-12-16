class VisibilityDTO {
  final String idQuestionBase;
  final bool isVisible;

  VisibilityDTO({
    required this.idQuestionBase,
    required this.isVisible,
  });

  Map<String, dynamic> toJson() {
    return {
      'id_question_base': idQuestionBase,
      'visible': isVisible,
    };
  }
}
