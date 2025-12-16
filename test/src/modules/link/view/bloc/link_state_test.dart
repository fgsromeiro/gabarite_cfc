import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

void main() {
  group('LinkStatus enum', () {
    test('should return isLoading correctly for each status', () {
      expect(LinkStatus.initial.isLoading, true);
      expect(LinkStatus.loading.isLoading, true);
      expect(LinkStatus.finding.isLoading, true);
      expect(LinkStatus.linking.isLoading, true);

      expect(LinkStatus.loaded.isLoading, false);
      expect(LinkStatus.finded.isLoading, false);
      expect(LinkStatus.linked.isLoading, false);
      expect(LinkStatus.error.isLoading, false);
    });

    test('should return isLoaded correctly for each status', () {
      expect(LinkStatus.loaded.isLoaded, true);
      expect(LinkStatus.finded.isLoaded, true);
      expect(LinkStatus.linked.isLoaded, true);

      expect(LinkStatus.initial.isLoaded, false);
      expect(LinkStatus.loading.isLoaded, false);
      expect(LinkStatus.finding.isLoaded, false);
      expect(LinkStatus.linking.isLoaded, false);
      expect(LinkStatus.error.isLoaded, false);
    });
  });

  group('LinkFilter enum', () {
    test('should return isFiltered correctly for each filter', () {
      expect(LinkFilter.linked.isFiltered, true);
      expect(LinkFilter.unlinked.isFiltered, true);
      expect(LinkFilter.none.isFiltered, false);
    });
  });

  group('LinkState', () {
    test('should create initial state correctly', () {
      final state = LinkState.initial();

      expect(state.status, LinkStatus.initial);
      expect(state.filter, LinkFilter.none);
      expect(state.questions, isEmpty);
      expect(state.questionsFiltered, isEmpty);
      expect(state.questionsRefs, isEmpty);
      expect(state.listOfIdQuestionsLinked, isEmpty);
      expect(state.indexJump, 0);
      expect(state.noteSelected, isNull);
      expect(state.message, isNull);
    });

    test('should return isEmpty correctly', () {
      final emptyState = LinkState.initial();
      expect(emptyState.isEmpty, true);

      final nonEmptyState = emptyState.copyWith(
        questionsFiltered: [TBL0002.instance()],
      );
      expect(nonEmptyState.isEmpty, false);
    });

    test('should return isFilteredAndEmpty correctly', () {
      final state = LinkState.initial();

      final filteredEmptyState = state.copyWith(
        filter: LinkFilter.linked,
        questionsFiltered: [],
      );
      expect(filteredEmptyState.isFilteredAndEmpty, true);

      final filteredNonEmptyState = state.copyWith(
        filter: LinkFilter.unlinked,
        questionsFiltered: [TBL0002.instance()],
      );
      expect(filteredNonEmptyState.isFilteredAndEmpty, false);

      final nonFilteredEmptyState = state.copyWith(
        filter: LinkFilter.none,
        questionsFiltered: [],
      );
      expect(nonFilteredEmptyState.isFilteredAndEmpty, false);
    });

    test('should calculate countLinked correctly', () {
      final questions = [
        TBL0002.instance().copyWith(id: '1', idQuestionBase: 'base1', index: 0),
        TBL0002.instance().copyWith(id: '2', idQuestionBase: '', index: 1),
        TBL0002.instance().copyWith(id: '3', idQuestionBase: 'base3', index: 2),
        TBL0002.instance().copyWith(id: '4', idQuestionBase: '', index: 3),
      ];

      final state = LinkState.initial().copyWith(questions: questions);

      expect(state.countLinked, 2);
    });

    test('should copyWith correctly', () {
      final initial = LinkState.initial();
      final note = TBL0001.instance().copyWith(id: 'test_note');
      final questions = [TBL0002.instance()];

      final newState = initial.copyWith(
        status: LinkStatus.loaded,
        filter: LinkFilter.linked,
        questions: questions,
        questionsFiltered: questions,
        questionsRefs: [TBL0003.instance()],
        listOfIdQuestionsLinked: ['1', '2'],
        indexJump: 5,
        noteSelected: note,
        message: 'Test message',
      );

      expect(newState.status, LinkStatus.loaded);
      expect(newState.filter, LinkFilter.linked);
      expect(newState.questions, questions);
      expect(newState.questionsFiltered, questions);
      expect(newState.questionsRefs, hasLength(1));
      expect(newState.listOfIdQuestionsLinked, ['1', '2']);
      expect(newState.indexJump, 5);
      expect(newState.noteSelected, note);
      expect(newState.message, 'Test message');
    });

    test('copyWith should maintain old values when not provided', () {
      final original = LinkState(
        status: LinkStatus.loading,
        filter: LinkFilter.unlinked,
        questions: [TBL0002.instance().copyWith(id: '1', index: 0)],
        questionsFiltered: [TBL0002.instance().copyWith(id: '1', index: 0)],
        questionsRefs: [TBL0003.instance().copyWith(id: 'ref1')],
        listOfIdQuestionsLinked: ['1'],
        indexJump: 2,
        noteSelected: TBL0001.instance().copyWith(id: 'original_note'),
        message: 'Original message',
      );

      final copied = original.copyWith(status: LinkStatus.linked);

      expect(copied.status, LinkStatus.linked);
      expect(copied.filter, LinkFilter.unlinked);
      expect(copied.questions, original.questions);
      expect(copied.questionsFiltered, original.questionsFiltered);
      expect(copied.questionsRefs, original.questionsRefs);
      expect(copied.listOfIdQuestionsLinked, original.listOfIdQuestionsLinked);
      expect(copied.indexJump, original.indexJump);
      expect(copied.noteSelected, original.noteSelected);
      expect(copied.message, original.message);
    });

    test('should compare equality correctly', () {
      final state1 = LinkState.initial();
      final state2 = LinkState.initial();
      final state3 = LinkState.initial().copyWith(status: LinkStatus.loading);

      expect(state1, equals(state2));
      expect(state1, isNot(equals(state3)));
    });

    test('props should include all properties', () {
      final state = LinkState.initial();
      final props = state.props;

      expect(props.length, 9);
      expect(props[0], LinkStatus.initial);
      expect(props[1], LinkFilter.none);
      expect(props[2], isEmpty);
      expect(props[3], isEmpty);
      expect(props[4], isEmpty);
      expect(props[5], isEmpty);
      expect(props[6], 0);
      expect(props[7], isNull);
      expect(props[8], isNull);
    });

    test('should handle null/empty lists in countLinked', () {
      final emptyState = LinkState.initial().copyWith(questions: []);
      expect(emptyState.countLinked, 0);

      final allUnlinkedState = LinkState.initial().copyWith(
        questions: [
          TBL0002.instance().copyWith(id: '1', idQuestionBase: '', index: 0),
          TBL0002.instance().copyWith(id: '2', idQuestionBase: '', index: 1),
        ],
      );
      expect(allUnlinkedState.countLinked, 0);

      final allLinkedState = LinkState.initial().copyWith(
        questions: [
          TBL0002.instance().copyWith(id: '1', idQuestionBase: 'base1', index: 0),
          TBL0002.instance().copyWith(id: '2', idQuestionBase: 'base2', index: 1),
        ],
      );
      expect(allLinkedState.countLinked, 2);
    });
  });

  group('Border Cases for LinkState', () {
    test('should handle negative indexJump', () {
      final state = LinkState.initial().copyWith(indexJump: -1);
      expect(state.indexJump, -1);
    });

    test('should handle large lists', () {
      final largeQuestionsList = List.generate(1000, (i) => TBL0002.instance().copyWith(id: '$i', index: i));
      final largeLinkedList = List.generate(500, (i) => '$i');

      final state = LinkState.initial().copyWith(
        questions: largeQuestionsList,
        listOfIdQuestionsLinked: largeLinkedList,
      );

      expect(state.questions, hasLength(1000));
      expect(state.listOfIdQuestionsLinked, hasLength(500));
    });

    test('should handle empty strings in listOfIdQuestionsLinked', () {
      final state = LinkState.initial().copyWith(
        listOfIdQuestionsLinked: ['', 'id1', ''],
      );

      expect(state.listOfIdQuestionsLinked, hasLength(3));
      expect(state.listOfIdQuestionsLinked, contains(''));
    });
  });
}
