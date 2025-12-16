import '../../../shared/export/app_export.dart';

abstract class VisibilityRepository {
  Future<List<TBL0002>> loadAllQuestions();
  Future<void> setVisibility(VisibilityDTO dto);
  Future<void> changeVisibilityAll(VisibilityDTO dto);
}

class VisibilityRepositoryImpl implements VisibilityRepository {
  final DataManager dataManager;
  final FunctionDatabase functionDatabase;
  final NetworkVerifier networkVerifier;

  VisibilityRepositoryImpl({required this.dataManager, required this.networkVerifier, required this.functionDatabase});

  @override
  Future<void> setVisibility(VisibilityDTO dto) async {
    try {
      await networkVerifier.verifyConnection();

      await functionDatabase.call(fn: SupabaseUtils.functionVisibilitySingleRPC, constrains: dto.toJson());

      return;
    } on CustomException {
      rethrow;
    }
  }

  @override
  Future<void> changeVisibilityAll(VisibilityDTO dto) async {
    try {
      await networkVerifier.verifyConnection();

      await functionDatabase.call(fn: SupabaseUtils.functionVisibilityAllRPC, constrains: {'visible': dto.isVisible});

      return;
    } on CustomException {
      rethrow;
    }
  }

  @override
  Future<List<TBL0002>> loadAllQuestions() async {
    try {
      await networkVerifier.verifyConnection();

      final dto = SupabaseDTO(value: '', table: SupabaseUtils.kTBL0002, data: {}, column: '');

      final response = await dataManager.findAll(dto: dto);

      return (response).map((e) => TBL0002.fromMap(e)).toList();
    } on CustomException {
      rethrow;
    }
  }
}
