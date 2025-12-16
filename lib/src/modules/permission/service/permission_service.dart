import 'package:gabarite_cfc/src/shared/export/app_export.dart';

abstract class PermissionService {
  Future<TBL0004> getPermission(SupabaseDTO dto);
  Future<List<TBL0004>> findAllPermissionsUsers();
  Future<void> updatePermission(TBL0004 permission);
  Future<void> createPermission(TBL0004 permission);
}

class PermissionServiceImpl implements PermissionService {
  final PermissionRepository repository;

  PermissionServiceImpl({
    required this.repository,
  });

  @override
  Future<TBL0004> getPermission(SupabaseDTO dto) async {
    return await repository.get(dto);
  }

  @override
  Future<void> createPermission(TBL0004 permission) async {
    return await repository.create(permission);
  }

  @override
  Future<List<TBL0004>> findAllPermissionsUsers() async {
    return await repository.findAll();
  }

  @override
  Future<void> updatePermission(TBL0004 permission) async {
    return await repository.update(permission);
  }
}
