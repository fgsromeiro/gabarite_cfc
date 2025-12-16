import 'package:correcao_cfc/src/shared/export/app_export.dart';

abstract class PermissionRepository {
  Future<TBL0004> get(SupabaseDTO dto);
  Future<void> update(TBL0004 permission);
  Future<void> create(TBL0004 permission);
  Future<List<TBL0004>> findAll();
}

class PermissionRepositoryImpl implements PermissionRepository {
  final DataManager dataManager;
  final NetworkVerifier networkVerifier;

  PermissionRepositoryImpl({
    required this.dataManager,
    required this.networkVerifier,
  });

  @override
  Future<TBL0004> get(SupabaseDTO dto) async {
    try {
      await networkVerifier.verifyConnection();

      final response = await dataManager.findById(dto: dto);

      if (response.isNull) throw ErrorSupabaseException(message: 'Permissão não encontrada');

      return TBL0004.fromMap(response!);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> create(TBL0004 permission) async {
    try {
      await networkVerifier.verifyConnection();

      await dataManager.create(
        dto: SupabaseDTO(
          value: '',
          table: SupabaseUtils.kTBL0004,
          data: permission.toMap(),
          column: '',
        ),
      );

      return;
    } on CustomException {
      rethrow;
    }
  }

  @override
  Future<List<TBL0004>> findAll() async {
    try {
      await networkVerifier.verifyConnection();

      final users = await dataManager.findAll(
        dto: SupabaseDTO(
          value: '',
          table: SupabaseUtils.kTBL0004,
          data: {},
          column: '',
        ),
      );

      return users.map((e) => TBL0004.fromMap(e)).toList();
    } on CustomException {
      rethrow;
    }
  }

  @override
  Future<void> update(TBL0004 permission) async {
    try {
      await networkVerifier.verifyConnection();

      await dataManager.update(
        dto: SupabaseDTO(
          value: permission.user,
          table: SupabaseUtils.kTBL0004,
          data: permission.toMap(),
          column: 'user_id',
        ),
      );

      return;
    } on CustomException {
      rethrow;
    }
  }
}
