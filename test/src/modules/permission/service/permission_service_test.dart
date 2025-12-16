import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../fixture_reader.dart';
import '../../../../mocks/mocks.mocks.dart';

void main() {
  late MockPermissionRepository mockRepository;
  late PermissionService service;
  late TBL0004 permission;
  late Map<String, dynamic> dataListMap;
  late List<TBL0004> permissions;
  late SupabaseDTO dto;

  setUp(
    () {
      permission = TBL0004.fromMap(fixture('permission.json'));
      dataListMap = fixture('list_of_permission.json');
      permissions = (dataListMap['permissions'] as List).map((e) => TBL0004.fromMap(e)).toList();
      dto = SupabaseDTO(value: 'any_id', column: 'any_column', data: {}, table: 'any_table');
      mockRepository = MockPermissionRepository();
      service = PermissionServiceImpl(repository: mockRepository);
    },
  );

  tearDown(
    () {
      reset(mockRepository);
    },
  );

  group('Test method getPermission()', () {
    void mockRequest() {
      when(mockRepository.get(any)).thenAnswer((_) async => permission);
    }

    void mockRequestError(CustomException exception) {
      when(mockRepository.get(any)).thenThrow(exception);
    }

    test(
      'should check permission for the correct parameters',
      () async {
        mockRequest();

        await expectLater(() => service.getPermission(dto), returnsNormally);
        verify(mockRepository.get(any)).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestError(ConnectionInternetErrorException());

        await expectLater(() => service.getPermission(dto), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockRepository.get(any)).called(1);
      },
    );

    test(
      'should launch an exception ErrorAuthSupabaseException when giving error requisition',
      () async {
        mockRequestError(ErrorAuthSupabaseException());

        await expectLater(() => service.getPermission(dto), throwsA(isA<ErrorAuthSupabaseException>()));
        verify(mockRepository.get(any)).called(1);
      },
    );
  });
  group('Test method findAllPermissionsUsers()', () {
    void mockRequest() {
      when(mockRepository.findAll()).thenAnswer((_) async => permissions);
    }

    void mockRequestError(CustomException exception) {
      when(mockRepository.findAll()).thenThrow(exception);
    }

    test(
      'should check findAllPermissionsUsers for the correct parameters',
      () async {
        mockRequest();

        await expectLater(() => service.findAllPermissionsUsers(), returnsNormally);
        verify(mockRepository.findAll()).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestError(ConnectionInternetErrorException());

        await expectLater(() => service.findAllPermissionsUsers(), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockRepository.findAll()).called(1);
      },
    );

    test(
      'should launch an exception ErrorAuthSupabaseException when giving error requisition',
      () async {
        mockRequestError(ErrorAuthSupabaseException());

        await expectLater(() => service.findAllPermissionsUsers(), throwsA(isA<ErrorAuthSupabaseException>()));
        verify(mockRepository.findAll()).called(1);
      },
    );
  });
  group('Test method updatePermission()', () {
    void mockRequest() {
      when(mockRepository.update(any)).thenAnswer((_) async => {});
    }

    void mockRequestError(CustomException exception) {
      when(mockRepository.update(any)).thenThrow(exception);
    }

    test(
      'should check updatePermission for the correct parameters',
      () async {
        mockRequest();

        await expectLater(() => service.updatePermission(permission), returnsNormally);
        verify(mockRepository.update(any)).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestError(ConnectionInternetErrorException());

        await expectLater(() => service.updatePermission(permission), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockRepository.update(any)).called(1);
      },
    );

    test(
      'should launch an exception ErrorAuthSupabaseException when giving error requisition',
      () async {
        mockRequestError(ErrorAuthSupabaseException());

        await expectLater(() => service.updatePermission(permission), throwsA(isA<ErrorAuthSupabaseException>()));
        verify(mockRepository.update(any)).called(1);
      },
    );
  });
  group('Test method createPermission()', () {
    void mockRequest() {
      when(mockRepository.create(any)).thenAnswer((_) async => {});
    }

    void mockRequestError(CustomException exception) {
      when(mockRepository.create(any)).thenThrow(exception);
    }

    test(
      'should check createPermission for the correct parameters',
      () async {
        mockRequest();

        await expectLater(() => service.createPermission(permission), returnsNormally);
        verify(mockRepository.create(any)).called(1);
      },
    );

    test(
      'should launch a ConnectionInternetException exception when you are without internet connection',
      () async {
        mockRequestError(ConnectionInternetErrorException());

        await expectLater(() => service.createPermission(permission), throwsA(isA<ConnectionInternetErrorException>()));
        verify(mockRepository.create(any)).called(1);
      },
    );

    test(
      'should launch an exception ErrorAuthSupabaseException when giving error requisition',
      () async {
        mockRequestError(ErrorAuthSupabaseException());

        await expectLater(() => service.createPermission(permission), throwsA(isA<ErrorAuthSupabaseException>()));
        verify(mockRepository.create(any)).called(1);
      },
    );
  });
}
