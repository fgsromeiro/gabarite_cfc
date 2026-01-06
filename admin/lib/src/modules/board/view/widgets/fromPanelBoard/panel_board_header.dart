import 'package:gabarite_cfc/src/modules/board/view/widgets/fromPanelBoard/panel_board_header_loading.dart';
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class PanelBoardHeader extends StatelessWidget {
  const PanelBoardHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<BoardBloc>();

    return BlocBuilder<BoardBloc, BoardState>(
      builder: (context, state) {
        if (state.status.isLoading) return PanelBoardHeaderLoading();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.sm,
          children: [
            AppHeader(
              spacing: AppSpacing.sm,
              title: 'Realizar Correção',
              description:
                  'Edite as questões do caderno de referência. As alterações serão sincronizadas com as questões vinculadas em outros cadernos.',
            ),
            Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: AppInsets.med,
              children: [
                Flexible(
                  flex: 8,
                  child: AppSearchBox(onChanged: bloc.search),
                ),
                Flexible(
                  flex: 2,
                  child: AppDropDownSimple(
                    onSelected: (value) {
                      if (value.isNull) return;

                      if (value == FilterQuestion.all.label) bloc.filterBy(FilterQuestion.all);
                      if (value == FilterQuestion.answered.label) bloc.filterBy(FilterQuestion.answered);
                      if (value == FilterQuestion.notAnswered.label) bloc.filterBy(FilterQuestion.notAnswered);
                    },
                    onValidator: (value) {
                      return null;
                    },
                    list: FilterQuestion.values.map((e) => e.label).toList(),
                    labelText: '',
                    hint: 'Filtrar por',
                    enable: true,
                    value: state.filterBy.label,
                  ),
                ),
                Tooltip(
                  message: 'Total de questões respondidas',
                  child: PanelBoardInfo(
                    icon: Icons.emoji_events,
                    label: 'Questões Respondidas:',
                    value: '${state.countAwnsered}/50',
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
