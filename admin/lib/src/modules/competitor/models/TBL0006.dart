// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../shared/export/app_export.dart';

class TBL0006 extends Equatable {
  String id;
  String atual;
  String official;
  String c1;
  String c2;
  String c3;
  String c4;
  String idNote;
  int index;

  TBL0006({
    required this.id,
    required this.atual,
    required this.official,
    required this.c1,
    required this.c2,
    required this.c3,
    required this.c4,
    required this.idNote,
    required this.index,
  });

  void setOfficial(String value) => official = value;

  void setC1(String value) => c1 = value;

  void setC2(String value) => c2 = value;

  void setC3(String value) => c3 = value;

  void setC4(String value) => c4 = value;

  bool get validate => atual == c1 && atual == c2 && atual == c3 && atual == c4 && atual == official;

  bool get isNotEmptyAll => c1.isNotEmpty && c2.isNotEmpty && c3.isNotEmpty && c4.isNotEmpty && official.isNotEmpty;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'atual': atual,
      'official': official,
      'c1': c1,
      'c2': c2,
      'c3': c3,
      'c4': c4,
      'idNote': idNote,
      'index': index,
    };
  }

  factory TBL0006.fromMap(Map<String, dynamic> map) {
    return TBL0006(
      id: map['id'] as String,
      atual: map['atual'] != null ? map['atual'] as String : '',
      official: map['official'] != null ? map['official'] as String : '',
      c1: map['c1'] != null ? map['c1'] as String : '',
      c2: map['c2'] != null ? map['c2'] as String : '',
      c3: map['c3'] != null ? map['c3'] as String : '',
      c4: map['c4'] != null ? map['c4'] as String : '',
      idNote: map['idNote'] != null ? map['idNote'] as String : '',
      index: map['index'] != null ? map['index'] as int : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TBL0006.fromJson(String source) => TBL0006.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [id, atual, official, c1, c2, c3, c4, idNote, index];
}
