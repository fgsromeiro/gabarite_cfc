import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class PanelBoardBody extends StatefulWidget {
  const PanelBoardBody({super.key});

  @override
  State<PanelBoardBody> createState() => _PanelBoardBodyState();
}

class _PanelBoardBodyState extends State<PanelBoardBody> {
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
          return PanelBoardBodyLoading();
        }
        if (state.listFiltered.isEmpty) {
          return Expanded(
            child: AppListEmpty(
              message: 'Ajuste os filtros ou tente uma nova pesquisa.',
            ),
          );
        }

        return Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: AppInsets.sm),
            child: ScrollablePositionedList.builder(
              itemCount: state.listFiltered.length,
              itemScrollController: _scrollController,
              itemBuilder: (context, index) {
                return PanelBoardEditLine(
                  question: state.listFiltered[index],
                  indexJump: index,
                );
              },
            ),
          ),
        );
      },
    );
  }
}
