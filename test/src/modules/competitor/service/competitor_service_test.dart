import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture_reader.dart';
import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockCompetitorRepository mockRepository;
  late CompetitorService service;
  late List<TBL0006> dataList;
  late TBL0006 mockCompetitor;

  setUp(
    () {
      dataList = [TBL0006.fromMap(fixture('competitors.json'))];
      mockRepository = MockCompetitorRepository();
      mockCompetitor = TBL0006.fromMap(fixture('competitors.json'));
      service = CompetitorsServiceImpl(remoteDataSource: mockRepository);
    },
  );

  tearDown(
    () {
      reset(mockRepository);
    },
  );

  group('findAllCompetitors', () {
    void mockRequest() {
      when(mockRepository.findAllByNote(any)).thenAnswer((_) async => dataList);
    }

    void mockRequestError(CustomException exception) {
      when(mockRepository.findAllByNote(any)).thenThrow(exception);
    }

    test(
      'should return a list of competitors correctly',
      () async {
        mockRequest();

        final result = await service.findAllByNote('anyId');

        expect(result, isA<List<TBL0006>>());
        verify(mockRepository.findAllByNote('anyId')).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestError(ConnectionInternetErrorException());

        expect(() => service.findAllByNote('anyId'), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockRepository.findAllByNote('anyId')).called(1);
      },
    );

    test(
      'should launch an exception ErrorSupabaseException when giving error requisition',
      () async {
        mockRequestError(ErrorSupabaseException());

        expect(() => service.findAllByNote('anyId'), throwsA(isA<ErrorSupabaseException>()));
        verify(mockRepository.findAllByNote('anyId')).called(1);
      },
    );
  });

  group(
    'updateRow',
    () {
      void mockRequest() {
        when(mockRepository.updateRow(any)).thenAnswer((_) async => Future.value());
      }

      void mockRequestError(CustomException exception) {
        when(mockRepository.updateRow(any)).thenThrow(exception);
      }

      test(
        'should update the data correctly',
        () async {
          mockRequest();

          expect(() => service.updateRow(mockCompetitor), returnsNormally);
          verify(mockRepository.updateRow(any)).called(1);
        },
      );

      test(
        'should launch a ConnectionInternetException exception when you are without internet connection',
        () async {
          mockRequestError(ConnectionInternetErrorException());

          expect(() => service.updateRow(mockCompetitor), throwsA(isA<ConnectionInternetErrorException>()));
          verify(mockRepository.updateRow(any)).called(1);
        },
      );

      test(
        'should launch an exception ErrorSupabaseException when giving error requisition',
        () async {
          mockRequestError(ErrorSupabaseException());

          expect(() => service.updateRow(mockCompetitor), throwsA(isA<ErrorSupabaseException>()));
          verify(mockRepository.updateRow(any)).called(1);
        },
      );
    },
  );

  group('dispose', () {
    test('should call remoteDataSource.dispose() once', () async {
      when(mockRepository.dispose()).thenAnswer((_) async => Future.value());

      await service.dispose();

      verify(mockRepository.dispose()).called(1);
    });

    test('should propagate error if remoteDataSource.dispose throws exception', () async {
      when(mockRepository.dispose()).thenThrow(ConnectionInternetErrorException());

      expect(
        () async => service.dispose(),
        throwsA(isA<ConnectionInternetErrorException>()),
      );

      verify(mockRepository.dispose()).called(1);
    });

    test('should complete without error when dispose is successful', () async {
      when(mockRepository.dispose()).thenAnswer((_) async => Future.value());

      await expectLater(service.dispose(), completes);
    });
  });

  group('listenCompetitor', () {
    test('should emit the same values from the remoteDataSource stream', () async {
      when(mockRepository.listenCompetitor()).thenAnswer((_) => Stream.value(dataList.first));

      final result = await service.listenCompetitor().toList();

      expect(result.first.index, equals(1));
      verify(mockRepository.listenCompetitor()).called(1);
    });
  });
}
