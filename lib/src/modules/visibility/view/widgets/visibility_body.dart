import '../../../../shared/export/app_export.dart';

class VisibilityBody extends StatefulWidget {
  const VisibilityBody({super.key});

  @override
  State<VisibilityBody> createState() => _VisibilityBodyState();
}

class _VisibilityBodyState extends State<VisibilityBody> {
  late final VisibilityBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<VisibilityBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VisibilityBloc, VisibilityState>(
      bloc: _bloc..load(),
      listener: (context, state) {
        if (state.status.isError) {
          Dialogs.showDialogMessage(
            context,
            message: state.errorMessage!,
            color: context.colorScheme.error,
          );
        }
      },
      builder: (context, state) {
        if (state.status.isLoading) {
          return Center(
            child: AppCircularIndicator(),
          );
        }

        return ListView.builder(
          itemCount: state.questions.length,
          itemBuilder: (context, index) => VisibilityCard(
            visibility: state.questions[index],
          ),
        );
      },
    );
  }
}
