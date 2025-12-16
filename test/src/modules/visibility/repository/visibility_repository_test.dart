import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../fixture_reader.dart';
import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockDataManager mockDataManager;
  late MockFunctionDatabase mockFunctionDatabase;
  late MockNetworkVerifier mockNetworkVerifier;
  late Map<String, dynamic> mockDataNoteMap;
  late VisibilityDTO mockVisibilityDTO;
  late VisibilityRepository repository;

  setUp(() {
    mockDataManager = MockDataManager();
    mockFunctionDatabase = MockFunctionDatabase();
    mockNetworkVerifier = MockNetworkVerifier();
    mockDataNoteMap = fixture('list_of_questions_by_note.json');
    mockVisibilityDTO = VisibilityDTO(idQuestionBase: '', isVisible: true);
    repository = VisibilityRepositoryImpl(
      dataManager: mockDataManager,
      functionDatabase: mockFunctionDatabase,
      networkVerifier: mockNetworkVerifier,
    );
  });

  tearDown(() {
    reset(mockDataManager);
    reset(mockFunctionDatabase);
    reset(mockNetworkVerifier);
  });

  group('Test Method setVisibility()', () {
    void mockRequestSuccess() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => {});
      when(mockFunctionDatabase.call(fn: anyNamed('fn'), constrains: anyNamed('constrains'))).thenAnswer(
        (_) async => {},
      );
    }

    void mockRequestFailureByConnection() {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());
    }

    void mockRequestFailureByDatabase() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => {});
      when(mockFunctionDatabase.call(fn: anyNamed('fn'), constrains: anyNamed('constrains')))
          .thenThrow(ErrorSupabaseException());
    }

    test('should call setVisibility without errors', () async {
      mockRequestSuccess();

      await repository.setVisibility(mockVisibilityDTO);

      verify(mockNetworkVerifier.verifyConnection()).called(1);
      verify(mockFunctionDatabase.call(fn: anyNamed('fn'), constrains: anyNamed('constrains'))).called(1);
    });
    test('should throw ConnectionInternetErrorException when there is no internet connection', () async {
      mockRequestFailureByConnection();

      await expectLater(repository.setVisibility(mockVisibilityDTO), throwsA(isA<ConnectionInternetErrorException>()));
      verify(mockNetworkVerifier.verifyConnection()).called(1);
      verifyZeroInteractions(mockFunctionDatabase);
    });
    test('should throw ErrorSupabaseException when there is no internet connection', () async {
      mockRequestFailureByDatabase();

      await expectLater(repository.setVisibility(mockVisibilityDTO), throwsA(isA<ErrorSupabaseException>()));
      verify(mockNetworkVerifier.verifyConnection()).called(1);
      verify(mockFunctionDatabase.call(fn: anyNamed('fn'), constrains: anyNamed('constrains'))).called(1);
    });
  });
  group('Test Method changeVisibilityAll()', () {
    void mockRequestSuccess() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => {});
      when(mockFunctionDatabase.call(fn: anyNamed('fn'), constrains: anyNamed('constrains'))).thenAnswer(
        (_) async => {},
      );
    }

    void mockRequestFailureByConnection() {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());
    }

    void mockRequestFailureByDatabase() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => {});
      when(mockFunctionDatabase.call(fn: anyNamed('fn'), constrains: anyNamed('constrains')))
          .thenThrow(ErrorSupabaseException());
    }

    test('should call changeVisibilityAll without errors', () async {
      mockRequestSuccess();

      await repository.changeVisibilityAll(mockVisibilityDTO);

      verify(mockNetworkVerifier.verifyConnection()).called(1);
      verify(mockFunctionDatabase.call(fn: anyNamed('fn'), constrains: anyNamed('constrains'))).called(1);
    });
    test('should throw ConnectionInternetErrorException when there is no internet connection', () async {
      mockRequestFailureByConnection();

      expectLater(repository.changeVisibilityAll(mockVisibilityDTO), throwsA(isA<ConnectionInternetErrorException>()));
      verify(mockNetworkVerifier.verifyConnection()).called(1);
      verifyZeroInteractions(mockFunctionDatabase);
    });
    test('should throw ErrorSupabaseException when there is no internet connection', () async {
      mockRequestFailureByDatabase();

      await expectLater(repository.changeVisibilityAll(mockVisibilityDTO), throwsA(isA<ErrorSupabaseException>()));
      verify(mockNetworkVerifier.verifyConnection()).called(1);
      verify(mockFunctionDatabase.call(fn: anyNamed('fn'), constrains: anyNamed('constrains'))).called(1);
    });
  });
  group('Test Method loadAllQuestions()', () {
    late List<Map<String, dynamic>> mockQuestionsByNoteList;

    setUp(() {
      mockQuestionsByNoteList = (mockDataNoteMap['questions'] as List).map((e) => e as Map<String, dynamic>).toList();
    });

    void mockRequestSuccess() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => {});
      when(mockDataManager.findAll(dto: anyNamed('dto'))).thenAnswer((_) async => mockQuestionsByNoteList);
    }

    void mockRequestFailureByConnection() {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());
    }

    void mockRequestFailureByDatabase() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => {});
      when(mockDataManager.findAll(dto: anyNamed('dto'))).thenThrow(ErrorSupabaseException());
    }

    test('should call loadAllQuestions without errors', () async {
      mockRequestSuccess();

      final future = await repository.loadAllQuestions();

      expect(future.length, 3);
      verify(mockNetworkVerifier.verifyConnection()).called(1);
      verify(mockDataManager.findAll(dto: anyNamed('dto'))).called(1);
    });
    test('should throw ConnectionInternetErrorException when there is no internet connection', () async {
      mockRequestFailureByConnection();

      await expectLater(repository.loadAllQuestions(), throwsA(isA<ConnectionInternetErrorException>()));
      verify(mockNetworkVerifier.verifyConnection()).called(1);
      verifyZeroInteractions(mockFunctionDatabase);
    });
    test('should throw ErrorSupabaseException when there is no internet connection', () async {
      mockRequestFailureByDatabase();

      await expectLater(repository.loadAllQuestions(), throwsA(isA<ErrorSupabaseException>()));
      verify(mockNetworkVerifier.verifyConnection()).called(1);
      verify(mockDataManager.findAll(dto: anyNamed('dto'))).called(1);
    });
  });
}
