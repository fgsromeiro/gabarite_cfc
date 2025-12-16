import 'package:correcao_cfc/src/ui/global/app_divider.dart';

import '../../../../shared/export/app_export.dart';

class CompetitorBoard extends StatelessWidget {
  const CompetitorBoard({super.key});

  @override
  Widget build(BuildContext context) {
    final note = context.watch<NoteBloc>().state.reference;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(AppInsets.med),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.med,
          children: [
            AppBarContainer(),
            AppContent(
              child: Column(
                spacing: AppSpacing.med,
                children: [
                  CompetitorHeader(),
                  AppDivider(),
                  Expanded(child: CompetitorsBody(reference: note!)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
