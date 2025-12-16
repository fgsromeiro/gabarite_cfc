import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockSettingRepository mockRepository;
  late SettingService service;
  late TBL0005 mockDisplay;

  setUp(
    () {
      mockDisplay = TBL0005(showButtons: false);
      mockRepository = MockSettingRepository();
      service = SettingServiceImpl(repository: mockRepository);
    },
  );

  tearDown(() => reset(mockRepository));

  group('Test method reset()', () {
    void mockRequest() {
      when(mockRepository.reset()).thenAnswer((_) async => Future.value());
    }

    void mockRequestError(CustomException exception) {
      when(mockRepository.reset()).thenThrow(exception);
    }

    test(
      'should check reset for the correct parameters',
      () async {
        mockRequest();

        await expectLater(() => service.reset(), returnsNormally);
        verify(mockRepository.reset()).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestError(ConnectionInternetErrorException());

        await expectLater(() => service.reset(), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockRepository.reset()).called(1);
      },
    );
    test(
      'should launch an exception ErrorSupabaseException when giving error requisition',
      () async {
        mockRequestError(ErrorSupabaseException());

        await expectLater(() => service.reset(), throwsA(isA<ErrorSupabaseException>()));
        verify(mockRepository.reset()).called(1);
      },
    );
  });
  group('Test method toggleButtons()', () {
    void mockRequest() {
      when(mockRepository.toggleButtons(any)).thenAnswer((_) async => Future.value());
    }

    void mockRequestError(CustomException exception) {
      when(mockRepository.toggleButtons(any)).thenThrow(exception);
    }

    test(
      'should check toggleButtons for the correct parameters',
      () async {
        mockRequest();

        await expectLater(() => service.toggleButtons(mockDisplay), returnsNormally);
        verify(mockRepository.toggleButtons(any)).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestError(ConnectionInternetErrorException());

        await expectLater(() => service.toggleButtons(mockDisplay), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockRepository.toggleButtons(any)).called(1);
      },
    );

    test(
      'should launch an exception ErrorSupabaseException when giving error requisition',
      () async {
        mockRequestError(ErrorSupabaseException());

        await expectLater(() => service.toggleButtons(mockDisplay), throwsA(isA<ErrorSupabaseException>()));
        verify(mockRepository.toggleButtons(any)).called(1);
      },
    );
  });

  group('Test method getToggleButtons()', () {
    void mockRequest() {
      when(mockRepository.getToggleButtons()).thenAnswer((_) async => mockDisplay);
    }

    void mockRequestError(CustomException exception) {
      when(mockRepository.getToggleButtons()).thenThrow(exception);
    }

    test(
      'should check getToggleButtons for the correct parameters',
      () async {
        mockRequest();

        await expectLater(() => service.getToggleButtons(), returnsNormally);
        verify(mockRepository.getToggleButtons()).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestError(ConnectionInternetErrorException());

        await expectLater(() => service.getToggleButtons(), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockRepository.getToggleButtons()).called(1);
      },
    );

    test(
      'should launch an exception ErrorSupabaseException when giving error requisition',
      () async {
        mockRequestError(ErrorSupabaseException());

        await expectLater(() => service.getToggleButtons(), throwsA(isA<ErrorSupabaseException>()));
        verify(mockRepository.getToggleButtons()).called(1);
      },
    );
  });
}
