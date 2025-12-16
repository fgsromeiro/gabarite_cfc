import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gabarite_board_cfc/src/modules/panel/models/export_image.dart';
import 'package:gabarite_board_cfc/src/modules/panel/service/panel_service.dart';
import 'package:gabarite_board_cfc/src/modules/panel/view/bloc/panel_state.dart';

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
      emit(
        state.copyWith(
          status: PanelStatus.loading,
        ),
      );

      final list = await service.findAllQuestions();

      emit(
        state.copyWith(
          listOfQuestions: list,
          status: PanelStatus.loaded,
        ),
      );
    } catch (e) {
      log(e.toString());
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
        log('Error in listen to questions: $error');
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
        log('Error in listen to display settings: $error');
      },
    );
  }

  Future<void> exportPanelToImage(Image image, String name) async {
    try {
      await serviceExport.captureAndDownload(image, name);

      emit(
        state.copyWith(status: PanelStatus.exported, message: 'Quadro exportado com sucesso'),
      );

      return;
    } catch (e) {
      emit(
        state.copyWith(status: PanelStatus.error, message: e.toString()),
      );
    }
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    service.dispose();
    return super.close();
  }
}
