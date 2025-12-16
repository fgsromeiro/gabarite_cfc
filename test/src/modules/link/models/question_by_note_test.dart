import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture_reader.dart';

void main() {
  late Map<String, dynamic> fixtureData;
  late TBL0002 questionByNote;

  setUp(() {
    fixtureData = fixture('question_by_note.json');
    questionByNote = TBL0002(
      idQuestionBase: 'any_id_base',
      id: 'any_id',
      title: 'any_title',
      alternative: 'any_alternative',
      index: 1,
      visible: true,
      idNote: 'any_id_note',
      enunciated: 'any_enunciated',
      teacher: 'any_teacher',
      textAlternative: 'any_text_alternative',
    );
  });

  group('QuestionByNote', () {
    test('should boot correctly', () {
      expect(questionByNote.idQuestionBase, 'any_id_base');
      expect(questionByNote.enunciated, 'any_enunciated');
      expect(questionByNote.isEmpty, isFalse);
    });

    test('should create an instance with empty values', () {
      final dto = TBL0002.instance();
      expect(dto.idQuestionBase, '');
      expect(dto.alternative, '');
      expect(dto.index, 0);
      expect(dto.visible, isFalse);
      expect(dto.isEmpty, isTrue);
    });

    test('should create an instance with specific values', () {
      final dto = TBL0002(
        idQuestionBase: '',
        id: 'any_id',
        title: 'any_title',
        alternative: 'any_alternative',
        index: 1,
        visible: true,
        idNote: 'any_id_note',
        enunciated: 'any_enunciated',
        teacher: 'any_teacher',
        textAlternative: 'any_text_alternative',
      );
      expect(dto.isEmpty, isTrue);
    });

    test('should convert to a Map correctly', () {
      final map = questionByNote.toMap();

      expect(map.length, 8);
      expect(map.keys, contains('idQuestionBase'));
      expect(map.keys, isNot(contains('title')));
      expect(map.keys, isNot(contains('index')));
      expect(map['idQuestionBase'], 'any_id_base');
      expect(map['visible'], isTrue);
    });

    test('should create an instance from a Map correctly', () {
      final dto = TBL0002.fromMap(fixtureData);
      expect(dto.idQuestionBase, 'any_id_base');
      expect(dto.index, 1);
      expect(dto.visible, isTrue);
    });

    test('should copy with new values', () {
      final copied = questionByNote.copyWith(id: 'new_id', title: 'new_title');

      expect(copied.id, 'new_id', reason: 'should update id.');
      expect(copied.title, 'new_title', reason: 'should update title.');
      expect(copied.idQuestionBase, '', reason: 'should reset idQuestionBase to "" (logic ?? "").');
      expect(copied.alternative, '', reason: 'should reset alternative to "" (logic ?? "").');
      expect(copied.enunciated, '', reason: 'should reset enunciated to "" (logic ?? "").');
      expect(copied.index, questionByNote.index, reason: 'should use index ?? this.index.');
      expect(copied.visible, questionByNote.visible, reason: 'should use visible ?? this.visible.');
    });

    test('should copy with new values', () {
      final copied = questionByNote.copyWith(idQuestionBase: 'new_idQuestion', enunciated: 'new_enunciated');

      expect(copied.idQuestionBase, 'new_idQuestion');
      expect(copied.enunciated, 'new_enunciated');
      expect(copied.index, questionByNote.index, reason: 'index usa ?? this.index.');
    });
  });
}
