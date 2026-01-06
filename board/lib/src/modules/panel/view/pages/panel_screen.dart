import 'package:gabarite_board_cfc/src/shared/export/app_export.dart';

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
