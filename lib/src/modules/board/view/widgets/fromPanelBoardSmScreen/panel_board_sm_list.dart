
import 'package:correcao_cfc/src/shared/export/app_export.dart';

class PanelBoardSmList extends StatefulWidget {
  const PanelBoardSmList({super.key});

  @override
  State<PanelBoardSmList> createState() => _PanelBoardSmListState();
}

class _PanelBoardSmListState extends State<PanelBoardSmList> {
  late final BoardBloc bloc;
  final ItemScrollController _scrollController = ItemScrollController();

  var indexJump = 0;
  var countAwnsred = 0;

  @override
  void initState() {
    super.initState();
    bloc = context.read<BoardBloc>();
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
    return BlocConsumer<BoardBloc, BoardState>(
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
          return AppCircularIndicator();
        }
        return ScrollablePositionedList.builder(
          itemCount: state.listFiltered.length,
          itemScrollController: _scrollController,
          itemBuilder: (context, index) {
            return PanelBoardSmCard(
              question: state.listFiltered[index],
              indexJump: indexJump,
            );
          },
        );
      },
    );
  }
}
