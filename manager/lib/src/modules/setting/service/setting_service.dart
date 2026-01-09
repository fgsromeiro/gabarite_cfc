import 'package:gabarite_cfc/src/shared/export/app_export.dart';

abstract class SettingService {
  Future<void> reset();
  Future<void> toggleButtons(TBL0005 display);
  Future<TBL0005?> getToggleButtons();
}

class SettingServiceImpl implements SettingService {
  final SettingRepository repository;

  SettingServiceImpl({
    required this.repository,
  });

  @override
  Future<void> reset() async {
    return repository.reset();
  }

  @override
  Future<TBL0005?> getToggleButtons() async {
    return await repository.getToggleButtons();
  }

  @override
  Future<void> toggleButtons(TBL0005 display) async {
    return await repository.toggleButtons(display);
  }
}
