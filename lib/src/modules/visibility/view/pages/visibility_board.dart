import '../../../../shared/export/app_export.dart';

class VisibilityBoard extends StatelessWidget {
  const VisibilityBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<CompetitorBloc, CompetitorState>(
      listener: (context, state) {},
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VisibilityHeader(),
          SizedBox(height: AppSpacing.lg),
          Expanded(child: VisibilityBody()),
        ],
      ),
    );
  }
}
