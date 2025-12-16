import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../fixture_reader.dart';
import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockNetworkVerifier mockNetworkVerifier;
  late MockDataManager mockDataManager;
  late PermissionRepository repository;
  late Map<String, dynamic> dataMap;
  late Map<String, dynamic> dataListMap;
  late TBL0004 permission;
  late SupabaseDTO supabaseDTO;

  setUpAll(
    () {
      dataMap = fixture('permission.json');
      dataListMap = fixture('list_of_permission.json');
      permission = TBL0004.fromMap(dataMap);
      mockNetworkVerifier = MockNetworkVerifier();
      mockDataManager = MockDataManager();
      repository = PermissionRepositoryImpl(dataManager: mockDataManager, networkVerifier: mockNetworkVerifier);
      supabaseDTO = SupabaseDTO(value: 'any_id', table: 'any_table', data: {}, column: 'any_column');
    },
  );

  tearDownAll(
    () {
      reset(mockNetworkVerifier);
      reset(mockDataManager);
    },
  );

  group('Get', () {
    void mockRequest() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => {});
      when(mockDataManager.findById(dto: anyNamed('dto'))).thenAnswer((_) async => dataMap);
    }

    void mockRequestError() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
      when(mockDataManager.findById(dto: anyNamed('dto'))).thenThrow(ErrorSupabaseException());
    }

    void mockRequestErrorInternet() {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());
    }

    test('should return a Permission object when connection and data are found', () async {
      mockRequest();

      final result = await repository.get(supabaseDTO);

      expect(result, isA<TBL0004>());
    });

    test('should throw ConnectionInternetErrorException when verifyConnection fails', () async {
      mockRequestErrorInternet();

      expect(
        () async => await repository.get(supabaseDTO),
        throwsA(isA<ConnectionInternetErrorException>()),
      );
    });

    test('should throw ErrorSupabaseException when response is null', () async {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => {});
      when(mockDataManager.findById(dto: anyNamed('dto'))).thenAnswer((_) async => null);

      expect(
        () async => await repository.get(supabaseDTO),
        throwsA(isA<ErrorSupabaseException>()),
      );
    });

    test('should rethrow dataManager exception', () async {
      mockRequestError();

      expect(
        () async => await repository.get(supabaseDTO),
        throwsA(isA<ErrorSupabaseException>()),
      );
    });
  });
  group('FindAll', () {
    void mockRequest() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => {});
      when(mockDataManager.findAll(dto: anyNamed('dto')))
          .thenAnswer((_) async => (dataListMap['permissions'] as List).cast<Map<String, dynamic>>());
    }

    void mockRequestError() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
      when(mockDataManager.findAll(dto: anyNamed('dto'))).thenThrow(ErrorSupabaseException());
    }

    void mockRequestErrorInternet() {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());
    }

    test('should return a list of Permission objects when connection and data are found', () async {
      mockRequest();

      final result = await repository.findAll();

      expect(result, isA<List<TBL0004>>());
      expect(result.length, 3);
      verifyInOrder([
        mockNetworkVerifier.verifyConnection(),
        mockDataManager.findAll(dto: anyNamed('dto')),
      ]);
    });

    test('should throw ConnectionInternetErrorException when verifyConnection fails', () async {
      mockRequestErrorInternet();

      expect(
        () async => await repository.findAll(),
        throwsA(isA<ConnectionInternetErrorException>()),
      );
    });

    test('should throw ErrorSupabaseException when response is null', () async {
      mockRequestError();

      expect(
        () async => await repository.findAll(),
        throwsA(isA<ErrorSupabaseException>()),
      );
    });
  });
  group('Update', () {
    void mockRequest() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => {});
      when(mockDataManager.update(dto: anyNamed('dto'))).thenAnswer((_) async => Future.value());
    }

    void mockRequestError() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
      when(mockDataManager.update(dto: anyNamed('dto'))).thenThrow(ErrorSupabaseException());
    }

    void mockRequestErrorInternet() {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());
    }

    test('should update a Permission object when connection and data are valid', () async {
      mockRequest();

      await repository.update(permission);

      verifyInOrder([
        mockNetworkVerifier.verifyConnection(),
        mockDataManager.update(dto: anyNamed('dto')),
      ]);
    });

    test('should throw ConnectionInternetErrorException when verifyConnection fails', () async {
      mockRequestErrorInternet();

      expect(
        () => repository.update(permission),
        throwsA(isA<ConnectionInternetErrorException>()),
      );
    });

    test('should throw ErrorSupabaseException when response is null', () async {
      mockRequestError();

      expect(
        () => repository.update(permission),
        throwsA(isA<ErrorSupabaseException>()),
      );
    });
  });
  group('Create', () {
    void mockRequest() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async => {});
      when(mockDataManager.create(dto: anyNamed('dto'))).thenAnswer((_) async => Future.value());
    }

    void mockRequestError() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
      when(mockDataManager.create(dto: anyNamed('dto'))).thenThrow(ErrorSupabaseException());
    }

    void mockRequestErrorInternet() {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());
    }

    test('should create a Permission object when connection and data are valid', () async {
      mockRequest();

      await repository.create(permission);

      verifyInOrder([
        mockNetworkVerifier.verifyConnection(),
        mockDataManager.create(dto: anyNamed('dto')),
      ]);
    });

    test('should throw ConnectionInternetErrorException when verifyConnection fails', () async {
      mockRequestErrorInternet();

      expect(
        () => repository.create(permission),
        throwsA(isA<ConnectionInternetErrorException>()),
      );
    });

    test('should throw ErrorSupabaseException when response is null', () async {
      mockRequestError();

      expect(
        () => repository.create(permission),
        throwsA(isA<ErrorSupabaseException>()),
      );
    });
  });
}
