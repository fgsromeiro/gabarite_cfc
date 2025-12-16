import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';


import '../../../../fixture_reader.dart';
import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockNetworkVerifier mockNetworkVerifier;
  late MockAuthManager mockAuthManager;
  late MockDataManager mockDataManager;
  late AuthRepository repository;
  late Map<String, dynamic> dataMap;
  late AuthManagerDTO dto;

  setUpAll(
    () {
      dataMap = fixture('user_data.json');
      mockNetworkVerifier = MockNetworkVerifier();
      mockAuthManager = MockAuthManager();
      mockDataManager = MockDataManager();
      repository = AuthRepositoryImpl(
        authManager: mockAuthManager,
        networkVerifier: mockNetworkVerifier,
      );
      dto = AuthManagerDTO(
        email: Faker().internet.email(),
        password: Faker().internet.password(),
      );
    },
  );

  tearDown(
    () {
      reset(mockNetworkVerifier);
      reset(mockDataManager);
      reset(mockAuthManager);
    },
  );

  group('login', () {
    void mockRequest() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
      when(mockAuthManager.signIn(dto: anyNamed('dto'))).thenAnswer((_) async => dataMap);
    }

    void mockRequestError() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
      when(mockAuthManager.signIn(dto: anyNamed('dto'))).thenThrow(ErrorAuthSupabaseException());
    }

    void mockRequestErrorInternet() {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());
    }

    test(
      'should log in to the correct parameters',
      () async {
        mockRequest();

        await expectLater(() => repository.login(dto), returnsNormally);
        verify(mockNetworkVerifier.verifyConnection()).called(1);
        verify(mockAuthManager.signIn(dto: anyNamed('dto'))).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestErrorInternet();

        expect(() => repository.login(dto), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockNetworkVerifier.verifyConnection()).called(1);
      },
    );

    test(
      'should launch an exception ErrorAuthSupabaseException when giving error requisition',
      () async {
        mockRequestError();

        expect(() => repository.login(dto), throwsA(isA<ErrorAuthSupabaseException>()));
        verify(mockNetworkVerifier.verifyConnection()).called(1);
      },
    );
  });
  group('signUp', () {
    void mockRequest() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
      when(mockAuthManager.signUp(dto: anyNamed('dto'))).thenAnswer((_) async => dataMap);
    }

    void mockRequestError() {
      when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
      when(mockAuthManager.signUp(dto: anyNamed('dto'))).thenThrow(ErrorAuthSupabaseException());
    }

    void mockRequestErrorInternet() {
      when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());
    }

    test(
      'should sign up with the correct parameters',
      () async {
        mockRequest();

        await expectLater(() => repository.signUp(dto), returnsNormally);
        verify(mockNetworkVerifier.verifyConnection()).called(1);
        verify(mockAuthManager.signUp(dto: anyNamed('dto'))).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestErrorInternet();

        expect(() => repository.signUp(dto), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockNetworkVerifier.verifyConnection()).called(1);
      },
    );

    test(
      'should launch an exception ErrorAuthSupabaseException when giving error requisition',
      () async {
        mockRequestError();

        expect(() => repository.signUp(dto), throwsA(isA<ErrorAuthSupabaseException>()));
        verify(mockNetworkVerifier.verifyConnection()).called(1);
      },
    );
  });

  group(
    'logout',
    () {
      void mockRequest() {
        when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
        when(mockAuthManager.logOut()).thenAnswer((_) async => {});
      }

      void mockRequestError() {
        when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
        when(mockAuthManager.logOut()).thenThrow(ErrorAuthSupabaseException());
      }

      void mockRequestErrorInternet() {
        when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());
      }

      test(
        'should perform logout correctly',
        () async {
          mockRequest();

          await expectLater(() => repository.logout(), returnsNormally);
          verify(mockNetworkVerifier.verifyConnection()).called(1);
          verify(mockAuthManager.logOut()).called(1);
        },
      );

      test(
        'should launch a ConnectionInternetException exception when you are without internet connection',
        () async {
          mockRequestErrorInternet();

          expect(() => repository.logout(), throwsA(isA<ConnectionInternetErrorException>()));
          verify(mockNetworkVerifier.verifyConnection()).called(1);
          verifyZeroInteractions(mockDataManager);
        },
      );

      test(
        'should launch the 1nd exception ErrorAuthSupabaseException by updating the data',
        () async {
          mockRequestError();

          expect(() => repository.logout(), throwsA(isA<ErrorAuthSupabaseException>()));
          verify(mockNetworkVerifier.verifyConnection()).called(1);
        },
      );
    },
  );
  group(
    'currentUser',
    () {
      void mockRequest() {
        when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
        when(mockAuthManager.currentUser()).thenAnswer((_) => dataMap);
      }

      void mockRequestError() {
        when(mockNetworkVerifier.verifyConnection()).thenAnswer((_) async {});
        when(mockAuthManager.currentUser()).thenThrow(ErrorAuthSupabaseException());
      }

      void mockRequestErrorInternet() {
        when(mockNetworkVerifier.verifyConnection()).thenThrow(ConnectionInternetErrorException());
      }

      test(
        'should return the UserModel correctly',
        () async {
          mockRequest();

          final user = await repository.currentUser();

          expect(user.id, 'any_id');
          expect(user.email, 'any_email');
          expect(user.name, 'any_name');
          verify(mockNetworkVerifier.verifyConnection()).called(1);
          verify(mockAuthManager.currentUser()).called(1);
        },
      );

      test(
        'should launch a ConnectionInternetException exception when you are without internet connection',
        () async {
          mockRequestErrorInternet();

          expect(() => repository.currentUser(), throwsA(isA<ConnectionInternetErrorException>()));
          verify(mockNetworkVerifier.verifyConnection()).called(1);
          verifyZeroInteractions(mockAuthManager);
        },
      );

      test(
        'should launch the 1nd exception ErrorAuthSupabaseException by updating the data',
        () async {
          mockRequestError();

          expect(() => repository.currentUser(), throwsA(isA<ErrorAuthSupabaseException>()));
          verify(mockNetworkVerifier.verifyConnection()).called(1);
        },
      );
    },
  );
}
