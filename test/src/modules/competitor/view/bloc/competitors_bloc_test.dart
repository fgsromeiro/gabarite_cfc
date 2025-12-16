import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../../fixture_reader.dart';
import '../../../../../mocks/mocks.mocks.dart';

void main() {
  late MockCompetitorService mockService;
  late CompetitorBloc bloc;
  late TBL0006 competitor;
  late MockStreamSubscription mockSubscription;
  late CompetitorState state;

  setUp(() {
    mockService = MockCompetitorService();
    state = CompetitorState.initial();
    bloc = CompetitorBloc(service: mockService);
    competitor = TBL0006.fromMap(fixture('competitors.json'));
    mockSubscription = MockStreamSubscription<TBL0006>();
  });

  tearDown(() {
    reset(mockService);
  });

  group('CompetitorsBloc - Tests for the state initialization', () {
    test('should have initial state as CompetitorState.initial()', () {
      final bloc = CompetitorBloc(service: mockService);
      expect(bloc.state.status, state.status);
      bloc.close();
    });
  });

  group('CompetitorsBloc - Tests for the findAllByNote() method', () {
    blocTest<CompetitorBloc, CompetitorState>(
      'should emit [loading, loaded] when loading is successful',
      setUp: () {
        when(mockService.findAllByNote('any_id')).thenAnswer((_) async => List.empty());
      },
      build: () => bloc,
      act: (bloc) => bloc.load('any_id'),
      expect: () => [
        state.copyWith(status: CompetitorStatus.loading),
        state.copyWith(status: CompetitorStatus.loaded, competitors: List.empty(), idNote: 'any_id'),
      ],
      verify: (_) {
        verify(mockService.findAllByNote(any)).called(1);
      },
    );

    blocTest<CompetitorBloc, CompetitorState>(
      'should emit [loading, error] when loading fails',
      setUp: () => when(mockService.findAllByNote('any_id')).thenThrow(CustomException('any_message', 500)),
      build: () => bloc,
      act: (bloc) => bloc.load('any_id'),
      expect: () => [
        state.copyWith(status: CompetitorStatus.loading),
        state.copyWith(status: CompetitorStatus.error, message: 'any_message'),
      ],
      verify: (_) {
        verify(mockService.findAllByNote('any_id')).called(1);
      },
    );
  });

  group('CompetitorsBloc - Tests for the update() method', () {
    blocTest<CompetitorBloc, CompetitorState>(
      'should emit [changing, loaded] when update is successful',
      setUp: () => when(mockService.updateRow(any)).thenAnswer((_) async => Future.value()),
      build: () => bloc,
      act: (bloc) => bloc.update(competitor),
      expect: () => [
        state.copyWith(status: CompetitorStatus.changing),
        state.copyWith(status: CompetitorStatus.loaded),
      ],
      verify: (_) {
        verify(mockService.updateRow(competitor)).called(1);
      },
    );
    blocTest<CompetitorBloc, CompetitorState>(
      'should emit [changing, loaded] when update is successful',
      setUp: () => when(mockService.updateRow(any)).thenThrow(CustomException('any_message', 500)),
      build: () => bloc,
      act: (bloc) => bloc.update(competitor),
      expect: () => [
        state.copyWith(status: CompetitorStatus.changing),
        state.copyWith(status: CompetitorStatus.error, message: 'any_message'),
      ],
      verify: (_) {
        verify(mockService.updateRow(competitor)).called(1);
      },
    );
  });

  group('CompetitorsBloc - Tests for the listenToChanges() method', () {
    late StreamController<TBL0006> controller;

    setUp(() {
      controller = StreamController<TBL0006>();
    });

    tearDown(() {
      controller.close();
    });

    blocTest<CompetitorBloc, CompetitorState>(
      'should update the competitors list and reorder',
      build: () => bloc,
      setUp: () {
        when(mockService.listenCompetitor()).thenAnswer((_) => controller.stream);
      },
      seed: () => state.copyWith(status: CompetitorStatus.loaded, competitors: []),
      act: (bloc) async {
        await bloc.listenToChanges();
        controller.add(competitor);
        await Future.microtask(() {});
      },
      expect: () => [
        isA<CompetitorState>()
            .having((s) => s.competitors.length, 'length', 1)
            .having((s) => s.competitors.first.id, '', competitor.id),
      ],
    );

    blocTest<CompetitorBloc, CompetitorState>(
      'should not emit state (just log) when the stream throws an error',
      setUp: () {
        when(mockService.listenCompetitor()).thenAnswer((_) => controller.stream);
      },
      build: () => bloc,
      seed: () => state.copyWith(status: CompetitorStatus.loaded, competitors: []),
      act: (bloc) async {
        await bloc.listenToChanges();

        controller.addError('any_error');

        await Future.microtask(() {});
      },
      expect: () => <CompetitorState>[],
      verify: (_) {
        verify(mockService.listenCompetitor()).called(1);
      },
    );
  });

  group('CompetitorsBloc - Tests for the close() method', () {
    test('should cancel subscription and call dispose on service', () async {
      when(mockService.dispose()).thenAnswer((_) => Future.value());

      expect(() => bloc.close(), returnsNormally);
      verifyNever(mockSubscription.cancel());
      verify(mockService.dispose()).called(1);
    });
  });
}
