import 'package:correcao_cfc/src/shared/export/app_export.dart';
import 'package:correcao_cfc/src/ui/appBar/app_bar_simple.dart';
import 'package:correcao_cfc/src/ui/drawer/app_drawer.dart';

class CompetitorBoardSmScreen extends StatelessWidget {
  const CompetitorBoardSmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final note = context.watch<NoteBloc>().state.reference;
    return Scaffold(
      appBar: AppBarSimple(),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(AppInsets.med),
        margin: EdgeInsets.only(
          bottom: AppInsets.sm,
          left: AppInsets.sm,
          right: AppInsets.sm,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: context.colorScheme.onSecondaryFixedVariant,
          ),
        ),
        child: Column(
          children: [
            CompetitorHeader(),
            Expanded(child: CompetitorsBody(reference: note!)),
          ],
        ),
      ),
    );
  }
}
