// ignore_for_file: public_member_api_docs, sort_constructors_first
import '../../../../shared/export/app_export.dart';

class TableAnalyzerCompetitor extends StatelessWidget {
  const TableAnalyzerCompetitor({super.key, required this.competitors});

  final List<TBL0006> competitors;

  @override
  Widget build(BuildContext context) {
    final config = context.uiConfigurations.competitorConfig;

    return BlocBuilder<CompetitorBloc, CompetitorState>(
      builder: (context, state) {
        final bloc = context.read<CompetitorBloc>();
        return AppTable(
          width: double.infinity,
          columns: [
            AppColumnCellTable.create(context, columnWidth: config.columnWidth, title: 'QUESTÃO'),
            AppColumnCellTable.create(context, columnWidth: config.columnWidth, title: 'OFICIAL'),
            AppColumnCellTable.create(context, columnWidth: config.columnWidth, title: 'ATUAL'),
            AppColumnCellTable.create(context, columnWidth: config.columnWidth, title: 'C1'),
            AppColumnCellTable.create(context, columnWidth: config.columnWidth, title: 'C2'),
            AppColumnCellTable.create(context, columnWidth: config.columnWidth, title: 'C3'),
            AppColumnCellTable.create(context, columnWidth: config.columnWidth, title: 'C4'),
          ],
          rows: [
            ...competitors.map(
              (c) {
                return DataRow(color: WidgetStatePropertyAll(_validateWithColorRow(context, competitor: c)), cells: [
                  AppRowCellTable.create(
                    context,
                    title: '${c.index}',
                  ),
                  AppRowCellTable.field(
                    context,
                    title: c.official,
                    fator: config.fatorScaleField,
                    onChanged: (value) {
                      c.setOfficial(value);
                      bloc.update(c);
                    },
                  ),
                  AppRowCellTable.create(
                    context,
                    title: c.atual,
                  ),
                  AppRowCellTable.field(
                    context,
                    title: c.c1,
                    fator: config.fatorScaleField,
                    onChanged: (value) {
                      c.setC1(value);
                      bloc.update(c);
                    },
                  ),
                  AppRowCellTable.field(
                    context,
                    title: c.c2,
                    fator: config.fatorScaleField,
                    onChanged: (value) {
                      c.setC2(value);
                      bloc.update(c);
                    },
                  ),
                  AppRowCellTable.field(
                    context,
                    title: c.c3,
                    fator: config.fatorScaleField,
                    onChanged: (value) {
                      c.setC3(value);
                      bloc.update(c);
                    },
                  ),
                  AppRowCellTable.field(
                    context,
                    title: c.c4,
                    fator: config.fatorScaleField,
                    onChanged: (value) {
                      c.setC4(value);
                      bloc.update(c);
                    },
                  ),
                ]);
              },
            )
          ],
        );
      },
    );
  }

  Color? _validateWithColorRow(BuildContext context, {required TBL0006 competitor}) {
    if (competitor.atual.isNotEmpty && competitor.validate) {
      return context.colorScheme.onPrimary.withAlpha(40);
    } else if (competitor.atual.isNotEmpty && competitor.isNotEmptyAll) {
      return context.colorScheme.error.withAlpha(40);
    }

    return null;
  }
}
