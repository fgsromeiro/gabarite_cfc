// ignore_for_file: public_member_api_docs, sort_constructors_first

import '../../../shared/export/app_export.dart';

class TBL0006 extends Equatable {
  String id;
  String cf;
  String official;
  String papiro;
  String granCursos;
  String oswaldo;
  String estrategia;
  String idNote;
  int index;

  TBL0006({
    required this.id,
    required this.cf,
    required this.official,
    required this.papiro,
    required this.granCursos,
    required this.oswaldo,
    required this.estrategia,
    required this.idNote,
    required this.index,
  });

  void setPapiro(String value) => papiro = value;

  void setOfficial(String value) => official = value;

  void setGranCursos(String value) => granCursos = value;

  void setOswaldo(String value) => oswaldo = value;

  void setEstrategia(String value) => estrategia = value;

  bool get validate => cf == papiro && cf == granCursos && cf == oswaldo && cf == estrategia && cf == official;

  bool get isNotEmptyAll =>
      papiro.isNotEmpty && granCursos.isNotEmpty && oswaldo.isNotEmpty && estrategia.isNotEmpty && official.isNotEmpty;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'cf': cf,
      'official': official,
      'papiro': papiro,
      'grancursos': granCursos,
      'oswaldo': oswaldo,
      'estrategia': estrategia,
      'idNote': idNote,
      'index': index,
    };
  }

  factory TBL0006.fromMap(Map<String, dynamic> map) {
    return TBL0006(
      id: map['id'] as String,
      cf: map['cf'] != null ? map['cf'] as String : '',
      official: map['official'] != null ? map['official'] as String : '',
      papiro: map['papiro'] != null ? map['papiro'] as String : '',
      granCursos: map['grancursos'] != null ? map['grancursos'] as String : '',
      oswaldo: map['oswaldo'] != null ? map['oswaldo'] as String : '',
      estrategia: map['estrategia'] != null ? map['estrategia'] as String : '',
      idNote: map['idNote'] != null ? map['idNote'] as String : '',
      index: map['index'] != null ? map['index'] as int : 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory TBL0006.fromJson(String source) => TBL0006.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  List<Object> get props => [id, cf, official, papiro, granCursos, oswaldo, estrategia, idNote, index];
}
