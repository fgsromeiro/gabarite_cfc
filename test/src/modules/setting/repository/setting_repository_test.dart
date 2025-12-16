import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockDataManager mockDataManager;
  late MockFunctionDatabase mockFunctionDatabase;
  late MockNetworkVerifier mockNetworkVerifier;
  late SettingRepository repository;
  late Map<String, dynamic> mockResponse;
  late TBL0005 mockDisplay;

  setUp(() {
    mockDataManager = MockDataManager();
    mockFunctionDatabase = MockFunctionDatabase();
    mockNetworkVerifier = MockNetworkVerifier();
    mockResponse = {'showButtons': false};
    mockDisplay = TBL0005.fromMap(mockResponse);

    repository = SettingRepositoryImpl(
      dataManager: mockDataManager,
      functionDatabase: mockFunctionDatabase,
      networkVerifier: mockNetworkVerifier,
    );
  });

  group('Test methods reset()', () {
    void mockRequestSuccess() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => {});
      when(mockFunctionDatabase.call(fn: anyNamed('fn'), constrains: anyNamed('constrains')))
          .thenAnswer((_) async => {});
    }

    void mockRequestFailureConnection() {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());
    }

    void mockRequestFailureDatabase() {
      when(mockFunctionDatabase.call(fn: anyNamed('fn'), constrains: anyNamed('constrains')))
          .thenThrow(ErrorSupabaseException());
    }

    test('should call verifyConnection and functionDatabase.call correctly', () async {
      mockRequestSuccess();

      await repository.reset();

      verifyInOrder([
        mockNetworkVerifier.verifyConnection(),
        mockFunctionDatabase.call(fn: anyNamed('fn'), constrains: anyNamed('constrains')),
      ]);
    });
    test('should rethrow ConnectionInternetErrorException', () async {
      mockRequestFailureConnection();

      expect(() => repository.reset(), throwsA(isA<ConnectionInternetErrorException>()));
      verifyZeroInteractions(mockFunctionDatabase);
    });

    test('should rethrow ErrorSupabaseException from database', () async {
      mockRequestFailureDatabase();

      expect(() => repository.reset(), throwsA(isA<ErrorSupabaseException>()));
    });
  });
  group('Test methods toggleButtons()', () {
    void mockRequestSuccess() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => Future.value());
      when(mockDataManager.update(dto: anyNamed('dto'))).thenAnswer((_) async => mockResponse);
    }

    void mockRequestFailureConnection() {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());
    }

    void mockRequestFailureDatabase() {
      when(mockDataManager.update(dto: anyNamed('dto'))).thenThrow(ErrorSupabaseException());
    }

    test('should call verifyConnection and dataManager.update correctly', () async {
      mockRequestSuccess();

      await repository.toggleButtons(mockDisplay);

      verifyInOrder([
        mockNetworkVerifier.verifyConnection(),
        mockDataManager.update(dto: anyNamed('dto')),
      ]);
    });
    test('should rethrow ConnectionInternetErrorException', () async {
      mockRequestFailureConnection();

      expect(() => repository.toggleButtons(mockDisplay), throwsA(isA<ConnectionInternetErrorException>()));
      verifyZeroInteractions(mockDataManager);
    });

    test('should rethrow ErrorSupabaseException from database', () async {
      mockRequestFailureDatabase();

      expect(() => repository.toggleButtons(mockDisplay), throwsA(isA<ErrorSupabaseException>()));
    });
  });
  group('Test methods getToggleButtons()', () {
    void mockRequestSuccess() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => {});
      when(mockDataManager.findAll(dto: anyNamed('dto'))).thenAnswer((_) async => [mockResponse]);
    }

    void mockRequestFailureConnection() {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());
    }

    void mockRequestFailureDatabase() {
      when(mockDataManager.findAll(dto: anyNamed('dto'))).thenThrow(ErrorSupabaseException());
    }

    test('should call verifyConnection and dataManager.findAll correctly', () async {
      mockRequestSuccess();

      final result = await repository.getToggleButtons();

      expect(result, isA<TBL0005>());
      expect(result!.showButtons, isFalse);

      verify(mockNetworkVerifier.verifyConnection()).called(1);
      verify(mockDataManager.findAll(dto: anyNamed('dto'))).called(1);
    });
    test('should rethrow ConnectionInternetErrorException', () async {
      mockRequestFailureConnection();

      expect(() => repository.getToggleButtons(), throwsA(isA<ConnectionInternetErrorException>()));
      verifyZeroInteractions(mockDataManager);
    });

    test('should rethrow ErrorSupabaseException from database', () async {
      mockRequestFailureDatabase();

      expect(() => repository.getToggleButtons(), throwsA(isA<ErrorSupabaseException>()));
    });
  });
}
