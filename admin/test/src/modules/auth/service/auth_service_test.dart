import 'package:flutter_test/flutter_test.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockAuthRepository mockAuthRepository;
  late AuthService service;
  late UserModel userModel;
  late AuthManagerDTO dto;

  setUpAll(
    () {
      userModel = UserModel(id: 'any_id', email: 'any_email', name: 'any_name');
      dto = AuthManagerDTO(email: 'email', password: 'password', name: 'name');
      mockAuthRepository = MockAuthRepository();
      service = AuthServiceImpl(repository: mockAuthRepository);
    },
  );

  tearDown(
    () {
      reset(mockAuthRepository);
    },
  );

  group('login', () {
    void mockRequest() {
      when(mockAuthRepository.login(any)).thenAnswer((_) async => userModel);
    }

    void mockRequestError(CustomException exception) {
      when(mockAuthRepository.login(any)).thenThrow(exception);
    }

    test(
      'should login to the correct parameters',
      () async {
        mockRequest();

        await expectLater(() => service.login(dto), returnsNormally);
        verify(mockAuthRepository.login(any)).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestError(ConnectionInternetErrorException());

        await expectLater(() => service.login(dto), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockAuthRepository.login(any)).called(1);
      },
    );

    test(
      'should launch an exception ErrorAuthSupabaseException when giving error requisition',
      () async {
        mockRequestError(ErrorAuthSupabaseException());

        await expectLater(() => service.login(dto), throwsA(isA<ErrorAuthSupabaseException>()));
        verify(mockAuthRepository.login(any)).called(1);
      },
    );
  });
  group('signUp', () {
    void mockRequest() {
      when(mockAuthRepository.signUp(any)).thenAnswer((_) async => userModel);
    }

    void mockRequestError(CustomException exception) {
      when(mockAuthRepository.signUp(any)).thenThrow(exception);
    }

    test(
      'should sign up with the correct parameters',
      () async {
        mockRequest();

        await expectLater(() => service.signUp(dto), returnsNormally);
        verify(mockAuthRepository.signUp(any)).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestError(ConnectionInternetErrorException());

        await expectLater(() => service.signUp(dto), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockAuthRepository.signUp(any)).called(1);
      },
    );

    test(
      'should launch an exception ErrorAuthSupabaseException when giving error requisition',
      () async {
        mockRequestError(ErrorAuthSupabaseException());

        await expectLater(() => service.signUp(dto), throwsA(isA<ErrorAuthSupabaseException>()));
        verify(mockAuthRepository.signUp(any)).called(1);
      },
    );
  });

  group(
    'logout',
    () {
      void mockRequest() {
        when(mockAuthRepository.logout()).thenAnswer((_) async {});
      }

      void mockRequestError(CustomException exception) {
        when(mockAuthRepository.logout()).thenThrow(exception);
      }

      test(
        'should perform Logret correctly',
        () async {
          mockRequest();

          await expectLater(() => service.logout(), returnsNormally);
          verify(mockAuthRepository.logout()).called(1);
        },
      );

      test(
        'should launch a ConnectionInternetException exception when you are without internet connection',
        () async {
          mockRequestError(ConnectionInternetErrorException());

          await expectLater(() => service.logout(), throwsA(isA<ConnectionInternetErrorException>()));
          verify(mockAuthRepository.logout()).called(1);
        },
      );

      test(
        'should launch exception ErrorAuthSupabaseException by updating the data',
        () async {
          mockRequestError(ErrorAuthSupabaseException());

          await expectLater(() => service.logout(), throwsA(isA<ErrorAuthSupabaseException>()));
          verify(mockAuthRepository.logout()).called(1);
        },
      );
    },
  );

  group(
    'currentUser',
    () {
      void mockRequest() {
        when(mockAuthRepository.currentUser()).thenAnswer((_) async => userModel);
      }

      void mockRequestError(CustomException exception) {
        when(mockAuthRepository.currentUser()).thenThrow(exception);
      }

      test(
        'should seek the user correctly',
        () async {
          mockRequest();

          await expectLater(() => service.currentUser(), returnsNormally);
          verify(mockAuthRepository.currentUser()).called(1);
        },
      );

      test(
        'should launch a ConnectionInternetException exception when you are without internet connection',
        () async {
          mockRequestError(ConnectionInternetErrorException());

          await expectLater(() => service.currentUser(), throwsA(isA<ConnectionInternetErrorException>()));
          verify(mockAuthRepository.currentUser()).called(1);
        },
      );

      test(
        'should launch exception ErrorAuthSupabaseException by updating the data',
        () async {
          mockRequestError(ErrorAuthSupabaseException());

          await expectLater(() => service.currentUser(), throwsA(isA<ErrorAuthSupabaseException>()));
          verify(mockAuthRepository.currentUser()).called(1);
        },
      );
    },
  );
}
