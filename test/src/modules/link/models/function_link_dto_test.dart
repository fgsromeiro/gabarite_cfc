import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../fixture_reader.dart';

void main() {
  late Map<String, dynamic> fixtureData;

  setUp(() {
    fixtureData = fixture('function_link_dto.json');
  });

  group('FunctionLinkDTO', () {
    test('should initialize all fields correctly', () {
      final dto = FunctionLinkDTO(
        id: fixtureData['id'] as String,
        idQuestionbase: fixtureData['idquestionbase'] as String,
        enunciated: fixtureData['enunciated'] as String,
        alternative: fixtureData['alternative'] as String,
        textAlternative: fixtureData['textAlternative'] as String,
        visible: fixtureData['visible'] as bool,
      );

      expect(dto.id, 'any_id');
      expect(dto.idQuestionbase, 'any_idquestionbase');
      expect(dto.enunciated, 'any_enunciated');
      expect(dto.alternative, 'any_alternative');
      expect(dto.textAlternative, 'any_textAlternative');
      expect(dto.visible, isTrue);
    });

    test('should initialize only the required parameter', () {
      final dto = FunctionLinkDTO(id: 'any_id');

      expect(dto.id, 'any_id');
      expect(dto.idQuestionbase, isNull);
      expect(dto.enunciated, isNull);
      expect(dto.alternative, isNull);
      expect(dto.textAlternative, isNull);
      expect(dto.visible, isNull);
    });

    test('should create an instance with default values', () {
      final dto = FunctionLinkDTO.instance();

      expect(dto.id, '', reason: 'ID should be an empty string.');
      expect(dto.idQuestionbase, isNull);
      expect(dto.enunciated, isNull);
      expect(dto.visible, isNull);
    });

    test('should convert all fields to a map', () {
      final dto = FunctionLinkDTO(
        id: 'any_id',
        idQuestionbase: 'any_idquestionbase',
        enunciated: 'any_enunciated',
        alternative: 'any_alternative',
        textAlternative: 'any_textAlternative',
        visible: false,
      );
      final map = dto.toMap();

      expect(map, isA<Map<String, dynamic>>());
      expect(map.length, 6);
      expect(map['id'], 'any_id');
      expect(map['idQuestionBase'], 'any_idquestionbase', reason: 'Should use CamelCase for the map key.');
      expect(map['enunciated'], 'any_enunciated');
      expect(map['alternative'], 'any_alternative');
      expect(map['textAlternative'], 'any_textAlternative');
      expect(map['visible'], isFalse);
    });

    test('should convert an object with null fields to a map', () {
      final dto = FunctionLinkDTO(id: 'any_id');
      final map = dto.toMap();

      expect(map['id'], 'any_id');
      expect(map['idQuestionBase'], isNull);
      expect(map['enunciated'], isNull);
      expect(map['alternative'], isNull);
      expect(map['textAlternative'], isNull);
      expect(map['visible'], isNull);
    });

    final originalDTO = FunctionLinkDTO(
      id: 'any_id',
      idQuestionbase: 'any_idquestionbase',
      visible: true,
      enunciated: 'any_enunciated',
    );

    test('should create a copy without changes', () {
      final copiedDTO = originalDTO.copyWith();

      expect(copiedDTO, isNot(same(originalDTO)));

      expect(copiedDTO.id, originalDTO.id);
      expect(copiedDTO.idQuestionbase, originalDTO.idQuestionbase);
      expect(copiedDTO.visible, originalDTO.visible);
      expect(copiedDTO.enunciated, originalDTO.enunciated);
      expect(copiedDTO.alternative, originalDTO.alternative);
    });

    test('should update a field', () {
      final copiedDTO = originalDTO.copyWith(visible: false);

      expect(copiedDTO.visible, isFalse, reason: 'The visible field should be changed.');

      expect(copiedDTO.id, originalDTO.id);
      expect(copiedDTO.idQuestionbase, originalDTO.idQuestionbase);
      expect(copiedDTO.enunciated, originalDTO.enunciated);
    });

    test('should update multiple fields', () {
      final copiedDTO = originalDTO.copyWith(
        enunciated: 'new_data_enunciated',
        textAlternative: 'new_data_textAlternative',
      );

      expect(copiedDTO.enunciated, 'new_data_enunciated');
      expect(copiedDTO.textAlternative, 'new_data_textAlternative');

      expect(copiedDTO.id, originalDTO.id);
      expect(copiedDTO.visible, originalDTO.visible);
    });

    test('should update the ID', () {
      final copiedDTO = originalDTO.copyWith(id: 'new_id');

      expect(copiedDTO.id, 'new_id');
      expect(copiedDTO.enunciated, originalDTO.enunciated);
    });
  });
}
