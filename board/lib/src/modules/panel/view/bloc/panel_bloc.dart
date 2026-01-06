import 'dart:developer';
import 'dart:ui' as ui;

import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

class PanelBloc extends Cubit<PanelState> {
  final PanelService service;
  final ExportImage serviceExport;
  StreamSubscription? _subscription;

  PanelBloc({
    required this.service,
    required this.serviceExport,
  }) : super(PanelState.initial());

  Future<void> load() async {
    try {
      emit(state.copyWith(status: PanelStatus.loading));

      final list = await service.findAllQuestions();

      emit(state.copyWith(listOfQuestions: list, status: PanelStatus.loaded));
    } catch (e) {
      log(
        'Erro carregar as questões do quadro',
        error: e,
        stackTrace: StackTrace.current,
        name: 'PanelBloc.load',
      );
      emit(state.copyWith(status: PanelStatus.error, message: 'Erro ao carregar as questões do quadro'));
      return;
    }
  }

  Future<void> listenToChanges() async {
    _subscription = service.listenQuestion().listen(
      (question) {
        final listUpdate = state.listOfQuestions.toList();
        listUpdate.removeWhere(
          (element) => element.id == question.id,
        );

        listUpdate.add(question);

        emit(
          state.copyWith(
            status: PanelStatus.loaded,
            listOfQuestions: listUpdate,
          ),
        );

        return;
      },
      onError: (error) {
        log(
          'Erro ao ouvir mudanças nas questões',
          error: error,
          stackTrace: StackTrace.current,
          name: 'PanelBloc.listenToChanges',
        );
      },
    );
  }

  Future<void> listenToChangesDisplay() async {
    _subscription = service.listenSettingDisplay().listen(
      (showButtons) {
        emit(
          state.copyWith(
            showButtonsDownload: showButtons,
          ),
        );
        return;
      },
      onError: (error) {
        log(
          'Erro ao ouvir mudanças na exibição dos botões',
          error: error,
          stackTrace: StackTrace.current,
          name: 'PanelBloc.listenToChangesDisplay',
        );
      },
    );
  }

  Future<void> exportPanelToImage(ui.Image image, String name) async {
    try {
      await serviceExport.captureAndDownload(image, name);

      emit(
        state.copyWith(
          status: PanelStatus.exported,
          message: 'Quadro exportado com sucesso',
        ),
      );

      return;
    } catch (e) {
      log(
        'Erro ao exportar o quadro para imagem',
        error: e,
        stackTrace: StackTrace.current,
        name: 'PanelBloc.exportPanelToImage',
      );

      emit(
        state.copyWith(status: PanelStatus.error, message: e.toString()),
      );
    }
  }

  @override
  Future<void> close() {
    try {
      _subscription?.cancel();
      service.dispose();
    } catch (e) {
      log(
        'Erro ao fechar o PanelBloc',
        error: e,
        stackTrace: StackTrace.current,
        name: 'PanelBloc.close',
      );
    }
    return super.close();
  }
}
