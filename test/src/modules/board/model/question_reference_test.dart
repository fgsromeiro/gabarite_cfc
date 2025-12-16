import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture_reader.dart';

void main() {
  late TBL0003 question;
  late Map<String, dynamic> dataMap;

  setUp(() {
    dataMap = fixture('question_reference.json');
    question = TBL0003(
      id: 'any_id',
      title: 'any_title',
      alternative: 'any_alternative',
      index: 0,
      visible: true,
      idNote: 'any_idNote',
      enunciated: 'any_enunciated',
      teacher: 'any_teacher',
      textAlternative: 'any_textAlternative',
    );
  });

  test('it must be a question of question', () {
    expect(question, isA<Question>());
  });

  test('isFilled must be true when all mandatory fields are filled', () {
    expect(question.isFilled, isTrue);
  });

  test('isFilled must be false when a mandatory field is empty', () {
    final emptyEnunciated = question.copyWith(enunciated: '');
    expect(emptyEnunciated.isFilled, isFalse);

    final emptyTeacher = question.copyWith(teacher: '');
    expect(emptyTeacher.isFilled, isFalse);
  });

  test('instance() must return an instance with default values', () {
    final instance = TBL0003.instance();
    expect(instance.id, '');
    expect(instance.title, '');
    expect(instance.alternative, '');
    expect(instance.index, 0);
    expect(instance.visible, false);
    expect(instance.idNote, '');
    expect(instance.enunciated, '');
    expect(instance.teacher, '');
    expect(instance.textAlternative, '');
    expect(instance.isFilled, isFalse);
  });

  test('toMap() must return a map with the correct data', () {
    final map = question.toMap();
    expect(map['id'], question.id);
    expect(map['alternative'], question.alternative);
    expect(map['visible'], question.visible);
    expect(map['idNote'], question.idNote);
    expect(map['enunciated'], question.enunciated);
    expect(map['teacher'], question.teacher);
    expect(map['textAlternative'], question.textAlternative);
  });

  test('fromMap() must create an instance from a map', () {
    final newQuestion = TBL0003.fromMap(dataMap);

    expect(newQuestion, question);
    expect(newQuestion.id, question.id);
    expect(newQuestion.title, question.title);
  });

  test('fromMap() must deal with null fields', () {
    final mapWithNulls = {
      'id': '123',
      'title': 'Test title',
      'index': 1,
      'visible': true,
      'alternative': null,
      'idNote': null,
      'enunciated': null,
      'teacher': null,
      'textAlternative': null,
    };
    final newQuestion = TBL0003.fromMap(mapWithNulls);

    expect(newQuestion.alternative, '');
    expect(newQuestion.idNote, '');
    expect(newQuestion.enunciated, '');
    expect(newQuestion.teacher, '');
    expect(newQuestion.textAlternative, '');
  });

  test('toString() must return the title of the question', () {
    expect(question.toString(), question.title);
  });

  test('props must contain all properties', () {
    expect(
      question.props,
      equals([
        question.id,
        question.title,
        question.alternative,
        question.index,
        question.visible,
        question.idNote,
        question.enunciated,
        question.teacher,
        question.textAlternative,
      ]),
    );
  });
}
