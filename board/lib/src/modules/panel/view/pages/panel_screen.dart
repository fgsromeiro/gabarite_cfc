import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gabarite_board_cfc/src/modules/panel/view/bloc/panel_bloc.dart';
import 'package:gabarite_board_cfc/src/modules/panel/view/bloc/panel_state.dart';
import 'package:gabarite_board_cfc/src/modules/panel/view/widgets/panel_body.dart';
import 'package:gabarite_board_cfc/src/ui/informatives/app_loading_indicator.dart';

class PanelScreen extends StatefulWidget {
  const PanelScreen({super.key});

  @override
  State<PanelScreen> createState() => _PanelScreenState();
}

class _PanelScreenState extends State<PanelScreen> {
  late final PanelBloc _bloc;

  @override
  void initState() {
    _bloc = context.read<PanelBloc>();
    _bloc.listenToChanges();
    _bloc.listenToChangesDisplay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PanelBloc, PanelState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state.status == PanelStatus.initial || state.status == PanelStatus.loading) {
            return Center(
              child: AppLoadingIndicator(),
            );
          }

          return PanelBody(
            questions: state.listOfQuestions,
          );
        },
      ),
    );
  }
}
