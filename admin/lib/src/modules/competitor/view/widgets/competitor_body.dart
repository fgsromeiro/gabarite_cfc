import 'package:gabarite_cfc/src/modules/competitor/view/widgets/table_analyzer_competitor.dart';

import '../../../../shared/export/app_export.dart';

class CompetitorsBody extends StatefulWidget {
  const CompetitorsBody({
    super.key,
    required this.reference,
  });

  final TBL0001 reference;

  @override
  State<CompetitorsBody> createState() => _CompetitorsBodyState();
}

class _CompetitorsBodyState extends State<CompetitorsBody> {
  late CompetitorBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = context.read<CompetitorBloc>();
    _bloc.load(widget.reference.id);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CompetitorBloc, CompetitorState>(
      builder: (context, state) {
        if (state.status == CompetitorStatus.loading) {
          return Center(child: AppCircularIndicator());
        } else if (state.competitors.isEmpty) {
          return AppListEmpty(
            message: 'Selecione um caderno para buscar as questões correspondentes',
          );
        }
        return TableAnalyzerCompetitor(competitors: state.competitors);
      },
    );
  }

  Widget _iconIndicator(BuildContext context, {required CompetitorState state, required TBL0006 competitor}) {
    if (competitor.cf.isNotEmpty && competitor.validate) {
      return Icon(Icons.check_circle_outline, color: context.colorScheme.onPrimary);
    } else if (competitor.cf.isNotEmpty && competitor.isNotEmptyAll) {
      return Icon(Icons.error_outline, color: context.colorScheme.error);
    }

    return const SizedBox.shrink();
  }

  Color? _validateWithColorRow(BuildContext context, {required TBL0006 competitor}) {
    if (competitor.cf.isNotEmpty && competitor.validate) {
      return context.colorScheme.onPrimary.withAlpha(40);
    } else if (competitor.cf.isNotEmpty && competitor.isNotEmptyAll) {
      return context.colorScheme.error.withAlpha(40);
    }

    return null;
  }
}
