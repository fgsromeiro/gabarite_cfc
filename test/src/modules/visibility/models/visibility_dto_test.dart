import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('VisibilityDTO', () {
    test('should instantiate correctly with valid values', () {
      final dto = VisibilityDTO(
        idQuestionBase: 'q123',
        isVisible: true,
      );

      expect(dto.idQuestionBase, equals('q123'));
      expect(dto.isVisible, isTrue);
    });

    test('toJson() should return the correct map when isVisible is true', () {
      final dto = VisibilityDTO(
        idQuestionBase: 'abc123',
        isVisible: true,
      );

      final map = dto.toJson();

      expect(map, {
        'id_question_base': 'abc123',
        'visible': true,
      });
    });

    test('toJson() should return the correct map when isVisible is false', () {
      final dto = VisibilityDTO(
        idQuestionBase: 'xyz789',
        isVisible: false,
      );

      final map = dto.toJson();

      expect(map, {
        'id_question_base': 'xyz789',
        'visible': false,
      });
    });

    test('toJson() should contain exactly two keys', () {
      final dto = VisibilityDTO(
        idQuestionBase: 'id001',
        isVisible: true,
      );

      final map = dto.toJson();

      expect(map.keys, containsAll(['id_question_base', 'visible']));
      expect(map.length, equals(2));
    });
  });
}
