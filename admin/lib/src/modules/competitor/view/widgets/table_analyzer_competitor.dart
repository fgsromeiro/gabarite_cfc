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
            AppColumnCellTable.create(context, columnWidth: config.columnWidth, title: 'CF'),
            AppColumnCellTable.create(context, columnWidth: config.columnWidth, title: 'OFICIAL'),
            AppColumnCellTable.create(context, columnWidth: config.columnWidth, title: 'PAPIRO'),
            AppColumnCellTable.create(context, columnWidth: config.columnWidth, title: 'GRAN CURSOS'),
            AppColumnCellTable.create(context, columnWidth: config.columnWidth, title: 'OSWALDO'),
            AppColumnCellTable.create(context, columnWidth: config.columnWidth, title: 'ESTRATÉGIA'),
          ],
          rows: [
            ...competitors.map(
              (c) {
                return DataRow(color: WidgetStatePropertyAll(_validateWithColorRow(context, competitor: c)), cells: [
                  AppRowCellTable.create(
                    context,
                    title: '${c.index}',
                  ),
                  AppRowCellTable.create(
                    context,
                    title: c.cf,
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
                  AppRowCellTable.field(
                    context,
                    title: c.papiro,
                    fator: config.fatorScaleField,
                    onChanged: (value) {
                      c.setPapiro(value);
                      bloc.update(c);
                    },
                  ),
                  AppRowCellTable.field(
                    context,
                    title: c.granCursos,
                    fator: config.fatorScaleField,
                    onChanged: (value) {
                      c.setGranCursos(value);
                      bloc.update(c);
                    },
                  ),
                  AppRowCellTable.field(
                    context,
                    title: c.oswaldo,
                    fator: config.fatorScaleField,
                    onChanged: (value) {
                      c.setOswaldo(value);
                      bloc.update(c);
                    },
                  ),
                  AppRowCellTable.field(
                    context,
                    title: c.estrategia,
                    fator: config.fatorScaleField,
                    onChanged: (value) {
                      c.setEstrategia(value);
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
    if (competitor.cf.isNotEmpty && competitor.validate) {
      return context.colorScheme.onPrimary.withAlpha(40);
    } else if (competitor.cf.isNotEmpty && competitor.isNotEmptyAll) {
      return context.colorScheme.error.withAlpha(40);
    }

    return null;
  }
}
