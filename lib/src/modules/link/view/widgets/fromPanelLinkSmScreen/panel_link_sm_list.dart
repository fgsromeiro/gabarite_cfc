import 'package:correcao_cfc/src/modules/link/view/widgets/fromPanelLinkSmScreen/panel_link_sm_card.dart';
import 'package:correcao_cfc/src/shared/export/app_export.dart';

class PanelLinkSmList extends StatefulWidget {
  const PanelLinkSmList({super.key});

  @override
  State<PanelLinkSmList> createState() => _PanelLinkSmListState();
}

class _PanelLinkSmListState extends State<PanelLinkSmList> {
  late final LinkBloc bloc;
  final ItemScrollController _scrollController = ItemScrollController();

  var indexJump = 0;
  var countAwnsred = 0;

  @override
  void initState() {
    super.initState();
    bloc = context.read<LinkBloc>();

    bloc.load();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (indexJump > 1) {
        _scrollController.scrollTo(
          index: indexJump - 1,
          duration: Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LinkBloc, LinkState>(builder: (context, state) {
      if (state.status.isLoaded && !state.isEmpty) {
        return ScrollablePositionedList.builder(
          itemScrollController: _scrollController,
          itemCount: state.questionsFiltered.length,
          itemBuilder: (context, index) => PanelLinkSmCard(
            enable: !state.noteSelected!.isReference,
            question: state.questionsFiltered[index],
          ),
        );
      } else if (state.status.isLoaded && state.isFilteredAndEmpty) {
        return AppListEmpty(
          message: 'Revise os filtros e tente novamente',
        );
      } else if (state.status.isLoaded && state.isEmpty) {
        return AppListEmpty(
          message: 'Selecione um caderno para buscar as questões correspondentes',
        );
      } else if (state.status.isLoading) {
        return AppCircularIndicator();
      }
      return AppError(message: state.message!);
    });
  }
}
