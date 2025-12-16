import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../fixture_reader.dart';

void main() {
  late TBL0003 mockQuestionA;
  late TBL0003 mockQuestionB;

  group('QuestionVisibility', () {
    setUp(() {
      mockQuestionA = TBL0003.fromMap(fixture('question_reference.json'));
      mockQuestionB = TBL0003.instance();
    });

    test('should instantiate correctly with default values', () {
      final qv = QuestionVisibility(questionBase: mockQuestionA);

      expect(qv.questionBase, equals(mockQuestionA));
      expect(qv.indexTypeOne, isNull);
      expect(qv.indexTypeTwo, isNull);
      expect(qv.indexTypeThree, isNull);
      expect(qv.indexTypeFour, isNull);
    });

    test('should return the title of the questionBase', () {
      final qv = QuestionVisibility(questionBase: mockQuestionA);

      expect(qv.title, equals('any_title'));
    });

    test('should return the visibility state of the questionBase', () {
      final qvVisible = QuestionVisibility(questionBase: mockQuestionA);
      final qvHidden = QuestionVisibility(questionBase: mockQuestionB);

      expect(qvVisible.isVisible, isTrue);
      expect(qvHidden.isVisible, isFalse);
    });

    test('copyWith should update only the provided fields', () {
      final qv = QuestionVisibility(
        questionBase: mockQuestionA,
        indexTypeOne: 1,
        indexTypeTwo: 2,
      );

      final updated = qv.copyWith(
        questionBase: mockQuestionB,
        indexTypeTwo: 99,
      );

      expect(updated.questionBase, equals(mockQuestionB));
      expect(updated.indexTypeOne, equals(1));
      expect(updated.indexTypeTwo, equals(99));
      expect(updated.indexTypeThree, isNull);
      expect(updated.indexTypeFour, isNull);
    });

    test('copyWith without parameters should return an identical copy', () {
      final qv = QuestionVisibility(
        questionBase: mockQuestionA,
        indexTypeOne: 10,
        indexTypeTwo: 20,
      );

      final copy = qv.copyWith();

      expect(copy, equals(qv));
      expect(identical(copy, qv), isFalse);
    });

    test('should return the visibility state of the questionBase', () {
      final qv1 = QuestionVisibility(
        questionBase: mockQuestionA,
        indexTypeOne: 1,
        indexTypeTwo: 2,
      );

      final qv2 = QuestionVisibility(
        questionBase: mockQuestionA,
        indexTypeOne: 1,
        indexTypeTwo: 2,
      );

      final qv3 = QuestionVisibility(
        questionBase: mockQuestionB,
        indexTypeOne: 1,
        indexTypeTwo: 2,
      );

      expect(qv1, equals(qv2));
      expect(qv1, isNot(equals(qv3)));
    });
  });
}
