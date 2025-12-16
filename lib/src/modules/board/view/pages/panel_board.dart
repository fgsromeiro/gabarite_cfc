import '../../../../shared/export/app_export.dart';

class PanelBoard extends StatefulWidget {
  const PanelBoard({super.key});

  @override
  State<PanelBoard> createState() => _PanelBoardState();
}

class _PanelBoardState extends State<PanelBoard> {
  late final BoardBloc bloc;
  final ItemScrollController _scrollController = ItemScrollController();

  var indexJump = 0;
  var countAwnsred = 0;

  @override
  void initState() {
    super.initState();
    bloc = context.read<BoardBloc>();

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
    return BlocConsumer<BoardBloc, BoardState>(
      bloc: bloc..load(),
      listener: (context, state) {
        if (state.status.isUpdated) {
          Future.delayed(Duration(milliseconds: 900), () {
            _scrollController.scrollTo(
              index: state.indexJump,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });
        }
      },
      builder: (context, state) {
        if (state.status == BoardStatus.loading) {
          return BoardPanelLoading();
        }
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.sm,
          children: [
            AppHeader(
              spacing: AppSpacing.sm,
              title: 'Realizar Correção',
              description:
                  'Edite as questões do caderno de referência. As alterações serão sincronizadas com as questões vinculadas em outros cadernos.',
            ),
            Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: AppInsets.med,
              children: [
                Flexible(flex: 8, child: BoardSearchBox()),
                Flexible(
                  flex: 2,
                  child: AppDropDownSimple(
                    onSelected: (value) {
                      if (value.isNull) return;

                      if (value == 'Todas') bloc.filterBy(FilterQuestion.all);
                      if (value == 'Respondidas') bloc.filterBy(FilterQuestion.answered);
                      if (value == 'Pendentes') bloc.filterBy(FilterQuestion.notAnswered);
                    },
                    onValidator: (value) {
                      return null;
                    },
                    list: ['Todas', 'Respondidas', 'Pendentes'],
                    labelText: '',
                    hint: 'Filtrar por',
                    enable: true,
                  ),
                ),
                Tooltip(
                  message: 'Total de questões respondidas',
                  child: BoardPanelInfo(
                    icon: Icons.emoji_events,
                    label: 'Questões Respondidas',
                    value: '${state.countAwnsered}/50',
                  ),
                ),
              ],
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(top: AppInsets.lg),
                child: ScrollablePositionedList.builder(
                  itemCount: state.listFiltered.length,
                  itemScrollController: _scrollController,
                  itemBuilder: (context, index) {
                    return BoardPanelEditLine(
                      question: state.listFiltered[index],
                      indexJump: index,
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
