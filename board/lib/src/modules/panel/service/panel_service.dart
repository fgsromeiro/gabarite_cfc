import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

abstract class PanelService {
  Future<List<Question>> findAllQuestions();
  Stream<Question> listenQuestion();
  Stream<bool> listenSettingDisplay();
  Future<void> dispose();
}

class PanelServiceImpl implements PanelService {
  final PanelRepository repository;

  PanelServiceImpl({required this.repository});

  @override
  Future<List<Question>> findAllQuestions() async {
    return await repository.findAllQuestions();
  }

  @override
  Stream<Question> listenQuestion() async* {
    yield* repository.listenQuestion();
  }

  @override
  Stream<bool> listenSettingDisplay() async* {
    yield* repository.listenSettingDisplay();
  }

  @override
  Future<void> dispose() async {
    await repository.dispose();
  }
}
