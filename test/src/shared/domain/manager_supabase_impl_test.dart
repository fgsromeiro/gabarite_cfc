import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../fixture_reader.dart';
import '../../../mocks/mocks.mocks.dart';

void main() {
  late MockSupabaseClient mockSupabaseClient;
  late MockSupabaseQueryBuilder mockSupabaseQueryBuilder;
  late MockPostgrestFilterBuilder<PostgrestList> mockPostgrestFilterBuilder;
  late MockPostgrestTransformBuilder<Map<String, dynamic>> mockPostgrestTransformBuilder;
  late DataManager repository;
  late List<Map<String, dynamic>> dataList;
  late Map<String, dynamic> dataMap;
  late SupabaseDTO dto;

  setUpAll(() {
    dto = SupabaseDTO(
        table: 'notes', value: 'any_id', column: 'any_column', data: {'title': 'any_title', 'content': 'any_content'});
    mockSupabaseClient = MockSupabaseClient();
    mockSupabaseQueryBuilder = MockSupabaseQueryBuilder();
    mockPostgrestFilterBuilder = MockPostgrestFilterBuilder();
    mockPostgrestTransformBuilder = MockPostgrestTransformBuilder();
    repository = ManagerSupabaseImpl(client: mockSupabaseClient);
    dataList = (fixture('list_of_notes.json')['notes'] as List).cast<Map<String, dynamic>>();
    dataMap = fixture('note.json');
  });

  tearDown(
    () {
      reset(mockSupabaseClient);
      reset(mockSupabaseQueryBuilder);
      reset(mockPostgrestFilterBuilder);
      reset(mockPostgrestTransformBuilder);
    },
  );

  group('findAll', () {
    void mockRequest() {
      when(mockSupabaseClient.from(any)).thenAnswer((_) => mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select()).thenAnswer((_) => mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.eq(any, any)).thenAnswer((_) => mockPostgrestFilterBuilder);
      when<Future<dynamic>>(
        mockPostgrestFilterBuilder.then<dynamic>(any, onError: anyNamed('onError')),
      ).thenAnswer((Invocation invocation) async {
        final onValue = invocation.positionalArguments[0] as Function;
        return onValue(dataList);
      });
    }

    test('should return a list of maps when Supabase query succeeds', () async {
      mockRequest();

      final result = await repository.findAll(dto: dto);

      expect(result.length, 4);
      verify(mockSupabaseClient.from(any)).called(1);
      verify(mockSupabaseQueryBuilder.select()).called(1);
    });

    test('should return a list of maps without filtering when Supabase query succeeds', () async {
      mockRequest();

      final result = await repository.findAll(dto: SupabaseDTO(table: 'notes', value: '', column: '', data: {}));

      expect(result.length, 4);
      verify(mockSupabaseClient.from(any)).called(1);
      verify(mockSupabaseQueryBuilder.select()).called(1);
    });

    test('should throw SupabaseException when Supabase query fails', () async {
      when(mockSupabaseClient.from(any)).thenAnswer((_) => mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select()).thenThrow(ErrorSupabaseException());

      expect(
        () => repository.findAll(dto: dto),
        throwsA(
          isA<CustomException>(),
        ),
      );
    });
  });
  group('findById', () {
    void mockRequest(Map<String, dynamic> data) {
      when(mockSupabaseClient.from(any)).thenAnswer((_) => mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select()).thenAnswer((_) => mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.eq(any, any)).thenAnswer((_) => mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.single()).thenAnswer((_) => mockPostgrestTransformBuilder);
      when<Future<dynamic>>(mockPostgrestTransformBuilder.then<dynamic>(any, onError: anyNamed('onError')))
          .thenAnswer((Invocation invocation) async {
        final onValue = invocation.positionalArguments[0] as Function;
        return onValue(data);
      });
    }

    void mockRequestError() {
      when(mockSupabaseClient.from(any)).thenAnswer((_) => mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.select()).thenThrow(ErrorSupabaseException());
    }

    test('should return a single map when record exists', () async {
      mockRequest(dataMap);

      final result = await repository.findById(dto: dto);

      expect(result, isA<Map<String, dynamic>>());
    });

    test('should return null when record does not exist', () async {
      mockRequest({});

      final result = await repository.findById(dto: dto);

      expect(result, null);
    });

    test('should return null if ID is empty', () async {
      final result = await repository.findById(dto: SupabaseDTO(table: 'any', value: '', column: '', data: {}));
      expect(result, null);
    });
    test('should throw SupabaseException when Supabase fail', () async {
      mockRequestError();

      expect(
        () => repository.findById(dto: SupabaseDTO(table: 'any', value: 'any', column: '', data: {})),
        throwsA(isA<CustomException>()),
      );
    });
  });
  group('create', () {
    void mockRequest() {
      when(mockSupabaseClient.from(any)).thenAnswer((_) => mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.insert(any)).thenAnswer((_) => mockPostgrestFilterBuilder);
      when<Future<dynamic>>(
        mockPostgrestFilterBuilder.then<dynamic>(any, onError: anyNamed('onError')),
      ).thenAnswer((Invocation invocation) async {
        final onValue = invocation.positionalArguments[0] as Function;
        return onValue;
      });
    }

    test('should insert data successfully', () async {
      mockRequest();

      expect(() => repository.create(dto: dto), returnsNormally);
      verify(mockSupabaseClient.from(any)).called(1);
      verify(mockSupabaseQueryBuilder.insert(any)).called(1);
    });

    test('should throw if entity is empty', () async {
      expect(
        () => repository.create(dto: SupabaseDTO(table: 'any', value: 'any', column: 'any', data: {})),
        throwsA(isA<CustomException>()),
      );
    });
  });
  group('remove', () {
    void mockRequest() {
      when(mockSupabaseClient.from(any)).thenAnswer((_) => mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.delete()).thenAnswer((_) => mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.eq(any, any)).thenAnswer((_) => mockPostgrestFilterBuilder);
      when<Future<dynamic>>(
        mockPostgrestFilterBuilder.then<dynamic>(any, onError: anyNamed('onError')),
      ).thenAnswer((Invocation invocation) async {
        final onValue = invocation.positionalArguments[0] as Function;
        return onValue;
      });
    }

    test('should remove record successfully', () async {
      mockRequest();

      expect(() => repository.delete(dto: dto), returnsNormally);
      verify(mockSupabaseClient.from(any)).called(1);
      verify(mockSupabaseQueryBuilder.delete()).called(1);
    });

    test('should throw if ID is empty', () async {
      expect(
        () => repository.delete(dto: SupabaseDTO(table: 'any', value: '', column: '', data: {})),
        throwsA(isA<CustomException>()),
      );
    });
  });
  group('update', () {
    void mockRequest() {
      when(mockSupabaseClient.from(any)).thenAnswer((_) => mockSupabaseQueryBuilder);
      when(mockSupabaseQueryBuilder.update(any)).thenAnswer((_) => mockPostgrestFilterBuilder);
      when(mockPostgrestFilterBuilder.eq(any, any)).thenAnswer((_) => mockPostgrestFilterBuilder);
      when<Future<dynamic>>(
        mockPostgrestFilterBuilder.then<dynamic>(any, onError: anyNamed('onError')),
      ).thenAnswer((Invocation invocation) async {
        final onValue = invocation.positionalArguments[0] as Function;
        return onValue;
      });
    }

    test('should update existing record', () async {
      mockRequest();

      expect(() => repository.update(dto: dto), returnsNormally);
      verify(mockSupabaseClient.from(any)).called(1);
      verify(mockSupabaseQueryBuilder.update(any)).called(1);
    });

    test('should throw if ID is empty', () async {
      expect(
        () => repository.update(dto: SupabaseDTO(table: 'any', value: '', column: '', data: {})),
        throwsA(isA<CustomException>()),
      );
    });
  });
}
