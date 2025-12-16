import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../fixture_reader.dart';
import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockRealtimeManager mockRealtimeManager;
  late MockDataManager mockDataManager;
  late MockNetworkVerifier mockNetworkVerifier;
  late CompetitorRepository repository;
  late Map<String, dynamic> mockData;
  late List<Map<String, dynamic>> mockDataList;
  late TBL0006 competitor;

  setUp(() {
    mockRealtimeManager = MockRealtimeManager();
    mockNetworkVerifier = MockNetworkVerifier();
    mockDataManager = MockDataManager();
    mockData = fixture('competitors.json');
    competitor = TBL0006.fromMap(mockData);
    mockDataList = fixture('list_of_competitors.json')['competitors'].cast<Map<String, dynamic>>();
    repository = CompetitorRepositoryImpl(
      realtimeManager: mockRealtimeManager,
      dataManager: mockDataManager,
      networkVerifier: mockNetworkVerifier,
    );
  });

  tearDown(() {
    reset(mockRealtimeManager);
    reset(mockDataManager);
    reset(mockNetworkVerifier);
  });

  test('should return a stream of Competitor correctly', () async {
    when(mockRealtimeManager.listen(dto: anyNamed('dto'))).thenAnswer((_) => Stream.value(mockData));

    final resultStream = repository.listenCompetitor();

    final result = await resultStream.first;

    expect(result, isA<TBL0006>());
  });

  test('should call disconnect when disposing', () async {
    when(mockRealtimeManager.disconnect()).thenAnswer((_) async => {});

    await repository.dispose();

    verify(mockRealtimeManager.disconnect()).called(1);
    verifyNoMoreInteractions(mockRealtimeManager);
  });

  group('findAllByNote', () {
    test('should return a list of Competitor when the connection is successful', () async {
      when(mockDataManager.findAll(dto: anyNamed('dto'))).thenAnswer((_) async => [mockData]);

      final result = await repository.findAllByNote('any_id_note');

      expect(result, isA<List<TBL0006>>());
    });

    test('should throw ConnectionInternetErrorException when the connection fails', () async {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());

      expect(
        () async => await repository.findAllByNote('any_id_note'),
        throwsA(isA<ConnectionInternetErrorException>()),
      );
    });
    test('should throw ErrorSupabaseException when the connection fails', () async {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ErrorSupabaseException());

      expect(
        () async => await repository.findAllByNote('any_id_note'),
        throwsA(isA<ErrorSupabaseException>()),
      );
    });

    test('should return a list of Competitor ordered by index', () async {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
      when(mockDataManager.findAll(dto: anyNamed('dto'))).thenAnswer((_) async => mockDataList);

      final result = await repository.findAllByNote('any_id_note');

      expect(result, isA<List<TBL0006>>());
      expect(result.length, 2);
      expect(result.first.index, equals(1));
      verify(mockNetworkVerifier.verifyConnection()).called(1);
      verify(mockDataManager.findAll(dto: anyNamed('dto'))).called(1);
    });
  });
  group('updateRow', () {
    test('should call verifyConnection and update with the correct data', () async {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
      when(mockDataManager.update(dto: anyNamed('dto'))).thenAnswer((_) async {});

      await repository.updateRow(competitor);

      verifyInOrder([
        mockNetworkVerifier.verifyConnection(),
        mockDataManager.update(dto: anyNamed('dto')),
      ]);

      verifyNoMoreInteractions(mockDataManager);
    });
  });

  test('should propagate ConnectionInternetErrorException if verifyConnection throws error', () async {
    when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());

    expect(
      () async => repository.updateRow(competitor),
      throwsA(isA<ConnectionInternetErrorException>()),
    );

    verify(mockNetworkVerifier.verifyConnection()).called(1);
    verifyNever(mockDataManager.update(dto: anyNamed('dto')));
  });

  test('should propagate ErrorSupabaseException if dataManager.update throws error', () async {
    when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
    when(mockDataManager.update(dto: anyNamed('dto'))).thenThrow(ErrorSupabaseException());

    expect(() async => repository.updateRow(competitor), throwsA(isA<ErrorSupabaseException>()));
    verify(mockNetworkVerifier.verifyConnection()).called(1);
  });

  test('should complete without error when update is successful', () async {
    when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
    when(mockDataManager.update(dto: anyNamed('dto'))).thenAnswer((_) async {});

    await expectLater(repository.updateRow(competitor), completes);
  });
}
