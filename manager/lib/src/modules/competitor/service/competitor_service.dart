import '../../../shared/export/app_export.dart';

abstract class CompetitorService {
  Future<List<TBL0006>> findAllByNote(String idNote);
  Future<void> updateRow(TBL0006 competitor);
  Stream<TBL0006> listenCompetitor();
  Future<void> dispose();
}

class CompetitorsServiceImpl implements CompetitorService {
  final CompetitorRepository remoteDataSource;

  CompetitorsServiceImpl({
    required this.remoteDataSource,
  });

  @override
  Future<List<TBL0006>> findAllByNote(String idNote) async {
    return remoteDataSource.findAllByNote(idNote);
  }

  @override
  Future<void> updateRow(TBL0006 competitor) async {
    return remoteDataSource.updateRow(competitor);
  }

  @override
  Future<void> dispose() async {
    return remoteDataSource.dispose();
  }

  @override
  Stream<TBL0006> listenCompetitor() async* {
    yield* remoteDataSource.listenCompetitor();
  }
}
