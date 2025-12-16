import 'package:correcao_cfc/src/shared/export/app_export.dart';

abstract class VisibilityService {
  Future<List<TBL0002>> loadAllQuestions();
  Future<void> setVisibility(VisibilityDTO dto);
  Future<void> changeVisibilityAll(VisibilityDTO dto);
}

class VisibilityServiceImpl implements VisibilityService {
  final VisibilityRepository repository;

  VisibilityServiceImpl({required this.repository});

  @override
  Future<void> setVisibility(VisibilityDTO dto) async {
    return repository.setVisibility(dto);
  }

  @override
  Future<void> changeVisibilityAll(VisibilityDTO dto) async {
    return repository.changeVisibilityAll(dto);
  }

  @override
  Future<List<TBL0002>> loadAllQuestions() {
    return repository.loadAllQuestions();
  }
}
