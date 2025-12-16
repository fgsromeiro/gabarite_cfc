import 'package:correcao_cfc/src/shared/export/app_export.dart';

class PanelLinkScreen extends StatefulWidget {
  const PanelLinkScreen({super.key});

  @override
  State<PanelLinkScreen> createState() => _PanelLinkScreenState();
}

class _PanelLinkScreenState extends State<PanelLinkScreen> {
  late final ItemScrollController _scrollController;
  late final LinkBloc _bloc;

  var indexJump = 0;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<LinkBloc>();
    _bloc.load();
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
    return BlocListener<LinkBloc, LinkState>(
      listenWhen: (previous, current) => previous.status != current.status,
      listener: (context, state) {
        if (state.status == LinkStatus.linked) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (_scrollController.isAttached) {
              _scrollController.scrollTo(
                index: state.indexJump,
                duration: const Duration(milliseconds: 500),
                curve: Curves.easeInOut,
              );
            }
          });

          Dialogs.showDialogMessage(
            context,
            message: state.message!,
            color: context.colorScheme.primary,
          );
        }
      },
      child: Column(
        children: [
          PanelLinkBoxHeader(),
          SizedBox(height: AppInsets.med),
          Expanded(
            child: PanelLinkBody(
              controller: _scrollController,
            ),
          ),
        ],
      ),
    );
  }
}
