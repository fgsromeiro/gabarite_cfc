import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../../fixture_reader.dart';

void main() {
  group('CompetitorStatus enum', () {
    test('should return isLoading correctly for each status', () {
      expect(CompetitorStatus.initial.isLoading, true);
      expect(CompetitorStatus.loading.isLoading, true);

      expect(CompetitorStatus.changing.isLoading, false);
      expect(CompetitorStatus.loaded.isLoading, false);
      expect(CompetitorStatus.error.isLoading, false);
    });

    test('should return isLoaded correctly for each status', () {
      expect(CompetitorStatus.loaded.isLoaded, true);

      expect(CompetitorStatus.initial.isLoaded, false);
      expect(CompetitorStatus.loading.isLoaded, false);
      expect(CompetitorStatus.changing.isLoaded, false);
      expect(CompetitorStatus.error.isLoaded, false);
    });
  });
  test('should return isChanging correctly for each status', () {
    expect(CompetitorStatus.changing.isChanging, true);

    expect(CompetitorStatus.initial.isChanging, false);
    expect(CompetitorStatus.loading.isChanging, false);
    expect(CompetitorStatus.loaded.isChanging, false);
    expect(CompetitorStatus.error.isChanging, false);
  });
  test('should return isError correctly for each status', () {
    expect(CompetitorStatus.error.isError, true);

    expect(CompetitorStatus.initial.isError, false);
    expect(CompetitorStatus.loading.isError, false);
    expect(CompetitorStatus.changing.isError, false);
    expect(CompetitorStatus.loaded.isError, false);
  });

  group('CompetitorState', () {
    late TBL0006 competitor;

    setUp(() {
      competitor = TBL0006.fromMap(fixture('competitors.json'));
    });
    test('should create initial state correctly', () {
      final state = CompetitorState.initial();

      expect(state.status, CompetitorStatus.initial);
      expect(state.competitors, isEmpty);
      expect(state.idNote, isEmpty);
      expect(state.message, isNull);
    });

    test('should copyWith correctly', () {
      final initial = CompetitorState.initial();

      final newState = initial.copyWith(
        status: CompetitorStatus.loaded,
        competitors: [competitor],
        idNote: 'any_note_id',
        message: 'any_message',
      );

      expect(newState.status, CompetitorStatus.loaded);
      expect(newState.competitors, isNotEmpty);
      expect(newState.idNote, equals('any_note_id'));
      expect(newState.message, equals('any_message'));
    });

    test('should compare equality correctly', () {
      final state1 = CompetitorState.initial();
      final state2 = CompetitorState.initial();
      final state3 = CompetitorState.initial().copyWith(status: CompetitorStatus.loading);

      expect(state1, equals(state2));
      expect(state1, isNot(equals(state3)));
    });
  });
}
