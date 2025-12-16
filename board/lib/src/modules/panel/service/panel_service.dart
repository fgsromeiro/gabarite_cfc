// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gabarite_board_cfc/src/modules/panel/data/panel_remote_data_source.dart';
import 'package:gabarite_board_cfc/src/modules/panel/models/question.dart';

abstract class PanelService {
  Future<List<Question>> findAllQuestions();
  Stream<Question> listenQuestion();
  Stream<bool> listenSettingDisplay();
  Future<void> dispose();
}

class PanelServiceImpl implements PanelService {
  final PanelRemoteDataSource repository;

  PanelServiceImpl({
    required this.repository,
  });

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
