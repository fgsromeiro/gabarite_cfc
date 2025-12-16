import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../fixture_reader.dart';

void main() {
  late TBL0003 qBase;
  late Map<String, dynamic> fixtureData;

  setUp(() {
    fixtureData = fixture('link_dto.json');

    qBase = TBL0003(
      id: 'any_id',
      alternative: 'any_alternative',
      visible: true,
      idNote: 'any_idNote',
      enunciated: 'any_enunciated',
      teacher: 'any_teacher',
      textAlternative: 'any_text_alternative',
      title: 'any_title',
      index: 0,
    );
  });

  group('LinkDTO', () {
    test('should create an instance with full values', () {
      final dto = LinkDTO(idQuestion: 'any_idQuestion', qBase: qBase);

      expect(dto.idQuestion, 'any_idQuestion');
      expect(dto.qBase, isA<TBL0003>());
      expect(dto.qBase.id, 'any_id');
      expect(dto.qBase.visible, isTrue);
    });

    test('should create an instance with minimal values', () {
      final dto = LinkDTO(idQuestion: 'any_idQuestion', qBase: qBase);

      expect(dto.idQuestion, 'any_idQuestion');
      expect(dto.qBase.id, 'any_id');
    });

    test('should convert the instance to a map', () {
      final dto = LinkDTO(idQuestion: 'any_idQuestion', qBase: qBase);
      final map = dto.toMap();

      expect(map.length, 8);

      expect(map['idQuestion'], 'any_idQuestion');

      expect(map['id'], 'any_id');
      expect(map['alternative'], 'any_alternative');
      expect(map['visible'], isTrue);
      expect(map['teacher'], 'any_teacher');
    });

    test('should create an instance from a map', () {
      final dto = LinkDTO.fromMap(fixtureData);

      expect(dto.idQuestion, 'any_idQuestion');
      expect(dto.qBase, isA<TBL0003>());
      expect(dto.qBase.id, 'any_id');
      expect(dto.qBase.enunciated, 'any_enunciated');
      expect(dto.qBase.visible, isFalse);
    });
  });
}
