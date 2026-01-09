import 'dart:developer';

import '../../../../shared/export/app_export.dart';

class CompetitorBloc extends Cubit<CompetitorState> with ApplicationGlobalMixin {
  final CompetitorService service;
  StreamSubscription<TBL0006>? _subscription;

  CompetitorBloc({
    required this.service,
  }) : super(CompetitorState.initial());

  Future<void> load(String id) async {
    try {
      emit(state.copyWith(status: CompetitorStatus.loading));

      final questions = await service.findAllByNote(id);

      emit(
        state.copyWith(
          status: CompetitorStatus.loaded,
          competitors: questions,
          idNote: id,
        ),
      );

      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: CompetitorStatus.error,
          message: e.toString(),
        ),
      );

      return;
    }
  }

  Future<void> update(TBL0006 competitor) async {
    try {
      emit(state.copyWith(status: CompetitorStatus.changing));

      await service.updateRow(competitor);

      emit(state.copyWith(status: CompetitorStatus.loaded));

      return;
    } catch (e) {
      emit(
        state.copyWith(
          status: CompetitorStatus.error,
          message: e.toString(),
        ),
      );

      return;
    }
  }

  Future<void> listenToChanges() async {
    _subscription = service.listenCompetitor().listen(
      (competitor) {
        final listUpdate = state.competitors.toList();
        listUpdate.removeWhere((element) => element.id == competitor.id);

        listUpdate.add(competitor);

        emit(
          state.copyWith(
            competitors: listUpdate..sort((a, b) => a.index.compareTo(b.index)),
          ),
        );
      },
      onError: (error) {
        log('Error in listen to competitors: $error');
      },
    );
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    service.dispose();
    return super.close();
  }
}
