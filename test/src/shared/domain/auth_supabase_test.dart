import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:faker/faker.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../mocks/mocks.mocks.dart';

void main() {
  late MockSupabaseClient mockClient;
  late AuthSupabaseImpl authSupabase;
  late MockGoTrueClient mockGoTrue;
  late MockAuthResponse mockAuthResponse;
  late User mockUser;
  late AuthManagerDTO mockAuthManagerDTO;
  late Faker faker;

  setUpAll(() {
    mockClient = MockSupabaseClient();
    mockGoTrue = MockGoTrueClient();
    authSupabase = AuthSupabaseImpl(client: mockClient);
    faker = Faker();
    mockUser = MockUser();
    mockAuthResponse = MockAuthResponse();
    mockAuthManagerDTO = AuthManagerDTO(
      email: faker.internet.email(),
      password: faker.internet.password(),
      name: faker.person.name(),
    );
    when(mockClient.auth).thenReturn(mockGoTrue);
  });

  tearDownAll(
    () {
      reset(mockClient);
      reset(mockGoTrue);
      reset(mockUser);
      reset(mockAuthResponse);
    },
  );

  group('AuthSupabase', () {
    group('currentUser', () {
      test('must return user data when a user is authenticated', () {
        when(mockGoTrue.currentUser).thenReturn(mockUser);
        when(mockUser.toJson()).thenReturn({'id': faker.guid.guid(), 'email': faker.internet.email()});

        final result = authSupabase.currentUser();

        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], isA<String>());
        expect(result['email'], isA<String>());
      });

      test('must throw ErrorAuthSupabaseException when there is no user', () {
        when(mockGoTrue.currentUser).thenReturn(null);

        expect(
          () => authSupabase.currentUser(),
          throwsA(isA<ErrorAuthSupabaseException>()),
        );
      });
    });

    group('logOut', () {
      test('must call signOut from Supabase successfully', () async {
        when(mockGoTrue.signOut()).thenAnswer((_) async {});

        await authSupabase.logOut();

        verify(mockGoTrue.signOut()).called(1);
      });

      test('must throw ErrorAuthSupabaseException when signOut fails', () {
        when(mockGoTrue.signOut()).thenThrow(Exception('Logout error'));

        expect(
          () => authSupabase.logOut(),
          throwsA(isA<ErrorAuthSupabaseException>()),
        );
      });
    });

    group('signIn', () {
      test('must return user data when login is successful', () async {
        when(
          mockGoTrue.signInWithPassword(
            email: anyNamed('email'),
            password: anyNamed('password'),
          ),
        ).thenAnswer((_) async => mockAuthResponse);

        when(mockAuthResponse.user).thenReturn(mockUser);

        when(mockUser.toJson()).thenReturn({'id': '456', 'email': 'test@example.com'});

        final result = await authSupabase.signIn(dto: mockAuthManagerDTO);

        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], '456');
      });

      test('must throw ErrorAuthSupabaseException when login fails', () {
        when(mockGoTrue.signInWithPassword(email: anyNamed('email'), password: anyNamed('password')))
            .thenThrow(Exception('Invalid credentials'));

        expect(
          () => authSupabase.signIn(dto: mockAuthManagerDTO),
          throwsA(isA<ErrorAuthSupabaseException>()),
        );
      });
    });

    group('signUp', () {
      test('must return user data when signUp is successful', () async {
        when(mockGoTrue.signUp(
          email: anyNamed('email'),
          password: anyNamed('password'),
          data: anyNamed('data'),
        )).thenAnswer((_) async => mockAuthResponse);

        when(mockAuthResponse.user).thenReturn(mockUser);

        when(mockUser.toJson()).thenReturn({'id': '789', 'email': 'newuser@example.com'});

        final result = await authSupabase.signUp(dto: mockAuthManagerDTO);

        expect(result, isA<Map<String, dynamic>>());
        expect(result['id'], '789');
      });

      test('must throw ErrorAuthSupabaseException when signUp fails', () {
        when(mockGoTrue.signUp(
          email: anyNamed('email'),
          password: anyNamed('password'),
          data: anyNamed('data'),
        )).thenThrow(Exception('User already exists'));

        expect(
          () => authSupabase.signUp(dto: mockAuthManagerDTO),
          throwsA(isA<ErrorAuthSupabaseException>()),
        );
      });
    });
  });
}
