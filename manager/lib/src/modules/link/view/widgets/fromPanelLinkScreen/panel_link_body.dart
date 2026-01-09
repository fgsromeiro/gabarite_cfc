import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class PanelLinkBody extends StatefulWidget {
  const PanelLinkBody({
    super.key,
  });

  @override
  State<PanelLinkBody> createState() => _PanelLinkBodyState();
}

class _PanelLinkBodyState extends State<PanelLinkBody> {
  late final ItemScrollController _scrollController;
  late final LinkBloc _bloc;

  var indexJump = 0;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<LinkBloc>();

    _scrollController = ItemScrollController();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (indexJump > 1 && _scrollController.isAttached) {
        _scrollController.scrollTo(
          index: indexJump + 6,
          duration: const Duration(seconds: 1),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LinkBloc, LinkState>(
      bloc: _bloc..loadQuestionsByNote(_bloc.state.noteSelected ?? TBL0001.instance()),
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == LinkStatus.linked) {
          Future.delayed(Duration(milliseconds: 900), () {
            _scrollController.scrollTo(
              index: state.indexJump,
              duration: Duration(milliseconds: 500),
              curve: Curves.easeInOut,
            );
          });

          Dialogs.showDialogMessage(
            context,
            message: state.message!,
            color: context.colorScheme.onPrimary,
          );
        }
      },
      builder: (context, state) {
        if (state.status.isLoading) return PanelBoardBodyLoading();

        if (state.questionsFiltered.isEmpty) {
          return Expanded(
            child: AppListEmpty(
              message: 'Ajuste os filtros ou tente uma nova pesquisa.',
            ),
          );
        }
        return Expanded(
          child: ScrollablePositionedList.builder(
            padding: EdgeInsets.only(top: AppInsets.sm),
            itemScrollController: _scrollController,
            itemCount: state.questionsFiltered.length,
            itemBuilder: (context, index) => PanelLinkCard(
              enable: !state.noteSelected!.isReference,
              question: state.questionsFiltered[index],
            ),
          ),
        );
      },
    );
  }
}
