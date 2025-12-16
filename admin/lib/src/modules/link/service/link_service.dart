import 'package:gabarite_cfc/src/shared/export/app_export.dart';

abstract class LinkService {
  Future<List<TBL0002>> findQuestionsByNote(String id);
  Future<void> link(FunctionLinkDTO dto);
  Future<void> removeLink(FunctionLinkDTO dto);
}

class LinkServiceImpl implements LinkService {
  final LinkRepository repository;

  LinkServiceImpl({
    required this.repository,
  });

  @override
  Future<List<TBL0002>> findQuestionsByNote(String id) async {
    return await repository.findQuestionsByNote(id);
  }

  @override
  Future<void> link(FunctionLinkDTO dto) async {
    return await repository.link(dto);
  }

  @override
  Future<void> removeLink(FunctionLinkDTO dto) async {
    return await repository.removeLink(dto);
  }
}
