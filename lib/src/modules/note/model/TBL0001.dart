import 'package:correcao_cfc/src/shared/export/app_export.dart';

class TBL0001 extends Equatable {
  final String id;
  final String title;
  final bool isReference;

  const TBL0001({
    required this.id,
    required this.title,
    required this.isReference,
  });

  factory TBL0001.instance() => TBL0001(id: '', title: '', isReference: false);

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'isReference': isReference,
    };
  }

  factory TBL0001.fromMap(Map<String, dynamic> map) {
    return TBL0001(
      id: map['id'] as String,
      title: map['title'] as String,
      isReference: map['isReference'] as bool,
    );
  }

  TBL0001 copyWith({
    String? id,
    String? title,
    bool? isReference,
  }) {
    return TBL0001(
      id: id ?? this.id,
      title: title ?? this.title,
      isReference: isReference ?? this.isReference,
    );
  }

  @override
  List<Object> get props => [
        id,
        title,
        isReference,
      ];

  @override
  String toString() {
    return title;
  }
}
