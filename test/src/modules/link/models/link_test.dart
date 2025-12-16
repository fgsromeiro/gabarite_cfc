import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/modules/link/models/link.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

void main() {
  late TBL0003 qBase1;
  late TBL0003 qBase2;
  late Map<int, TBL0003> qRefMapFull;
  late Link link;

  setUp(() {
    qBase1 = TBL0003.instance().copyWith(id: 'any_id_001');
    qBase2 = TBL0003.instance().copyWith(id: 'any_id_002');
    qRefMapFull = {
      1: TBL0003.instance().copyWith(id: 'Q1'),
      2: TBL0003.instance().copyWith(id: 'Q2'),
      3: TBL0003.instance().copyWith(id: 'Q3'),
      4: TBL0003.instance().copyWith(id: 'Q4'),
    };
    link = Link(questionBase: qBase1, mapQuestionsLinked: qRefMapFull);
  });

  group('Link Class Tests', () {
    test('should be created successfully', () {
      final link = Link(questionBase: qBase1, mapQuestionsLinked: qRefMapFull);
      expect(link, isNotNull);
      expect(link.questionBase.id, 'any_id_001');
      expect(link.mapQuestionsLinked.length, 4);
    });

    test('should be equal when two objects have the same values', () {
      final link1 = Link(questionBase: qBase1, mapQuestionsLinked: qRefMapFull);
      final link2 = Link(questionBase: qBase1, mapQuestionsLinked: qRefMapFull);
      expect(link1, link2);
    });

    test('should be different when two objects have different values', () {
      final link2 = Link(questionBase: qBase2, mapQuestionsLinked: qRefMapFull);

      expect(link, isNot(link2));
    });

    test('should be true when all 4 keys are present and IDs are not empty', () {
      expect(link.isLinked, isTrue);
    });

    test('should be false when one of the 4 keys has an empty ID', () {
      final mapWithEmptyId = {
        1: TBL0003.instance().copyWith(id: 'Q1'),
        2: TBL0003.instance(),
        3: TBL0003.instance().copyWith(id: 'Q3'),
        4: TBL0003.instance().copyWith(id: 'Q4'),
      };
      final link = Link(questionBase: qBase1, mapQuestionsLinked: mapWithEmptyId);
      expect(link.isLinked, isFalse);
    });

    test('should not modify the original object when copyWith is called without parameters', () {
      final copiedLink = link.copyWith();
      expect(copiedLink, link);
      expect(copiedLink, isNot(same(link)));
    });

    test('should update only questionBase when copyWith is called with new questionBase', () {
      final newQBase = TBL0003.instance().copyWith(id: 'NEW_QB');
      final copiedLink = link.copyWith(questionBase: newQBase);

      expect(copiedLink.questionBase.id, 'NEW_QB');
      expect(copiedLink.mapQuestionsLinked, link.mapQuestionsLinked);
      expect(copiedLink.isLinked, isTrue);
    });

    test('should update only mapQuestionsLinked when copyWith is called with new mapQuestionsLinked', () {
      final newMap = {
        1: TBL0003.instance().copyWith(id: 'NEW_Q1'),
        2: TBL0003.instance().copyWith(id: 'Q2'),
        3: TBL0003.instance().copyWith(id: 'Q3'),
        4: TBL0003.instance().copyWith(id: 'Q4')
      };
      final copiedLink = link.copyWith(mapQuestionsLinked: newMap);

      expect(copiedLink.mapQuestionsLinked[1]!.id, 'NEW_Q1');
      expect(copiedLink.questionBase, link.questionBase);
    });
  });
}
