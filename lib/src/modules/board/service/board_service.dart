import 'package:correcao_cfc/src/shared/export/app_export.dart';

abstract class BoardService {
  Future<List<TBL0003>> loadAllQuestions();
  Future<void> fillQuestion(TBL0003 question);
}

class BoardServiceImpl implements BoardService {
  final BoardRepository repository;

  BoardServiceImpl({
    required this.repository,
  });

  @override
  Future<void> fillQuestion(TBL0003 question) async {
    return await repository.update(question);
  }

  @override
  Future<List<TBL0003>> loadAllQuestions() async {
    final listFinded = await repository.findAll();

    return listFinded..sort((a, b) => a.index.compareTo(b.index));
  }
}
