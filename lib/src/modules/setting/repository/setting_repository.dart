import 'package:gabarite_cfc/src/shared/export/app_export.dart';

abstract class SettingRepository {
  Future<void> reset();
  Future<void> toggleButtons(TBL0005 display);
  Future<TBL0005?> getToggleButtons();
}

class SettingRepositoryImpl implements SettingRepository {
  final DataManager dataManager;
  final FunctionDatabase functionDatabase;
  final NetworkVerifier networkVerifier;

  SettingRepositoryImpl({
    required this.dataManager,
    required this.functionDatabase,
    required this.networkVerifier,
  });

  @override
  Future<void> reset() async {
    try {
      await networkVerifier.verifyConnection();

      await functionDatabase.call(fn: SupabaseUtils.functionResetRPC, constrains: {});

      return;
    } on CustomException {
      rethrow;
    }
  }

  @override
  Future<void> toggleButtons(TBL0005 display) async {
    try {
      await networkVerifier.verifyConnection();

      final dto = SupabaseDTO(
        value: SupabaseUtils.displayId,
        table: SupabaseUtils.kTBL0005,
        data: display.toMap(),
        column: 'id',
      );

      await dataManager.update(dto: dto);

      return;
    } on CustomException {
      rethrow;
    }
  }

  @override
  Future<TBL0005?> getToggleButtons() async {
    try {
      await networkVerifier.verifyConnection();

      final dto = SupabaseDTO(
        table: SupabaseUtils.kTBL0005,
        value: SupabaseUtils.displayId,
        data: {},
        column: 'id',
      );

      final response = await dataManager.findAll(dto: dto);

      return response.isNotNull && response.isNotEmpty ? TBL0005.fromMap(response.first) : null;
    } on CustomException {
      rethrow;
    }
  }
}
