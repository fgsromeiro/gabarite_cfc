import 'package:gabarite_cfc/src/modules/link/view/widgets/fromPanelLinkScreen/panel_link_header_loading.dart';

import '../../../../../shared/export/app_export.dart';

class PanelLinkHeader extends StatefulWidget {
  const PanelLinkHeader({super.key});

  @override
  State<PanelLinkHeader> createState() => _PanelLinkHeaderState();
}

class _PanelLinkHeaderState extends State<PanelLinkHeader> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<LinkBloc>();
    final stateNote = context.watch<NoteBloc>().state;
    final notes = stateNote.notes.where((n) => !n.isReference).toList();

    return BlocBuilder<LinkBloc, LinkState>(
      builder: (context, state) {
        if (state.status.isLoading) return PanelLinkHeaderLoading();

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: AppSpacing.med,
          children: [
            AppHeader(
              title: 'Vínculo de Questões',
              spacing: AppSpacing.sm,
              description:
                  'Selecione uma questão de cada lado para criar um vínculo. Cada questão de referência só pode ter um vínculo por caderno.',
            ),
            Flex(
              direction: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.end,
              spacing: AppInsets.med,
              children: [
                Flexible(
                  flex: 8,
                  child: AppSearchBox(
                    onChanged: bloc.search,
                  ),
                ),
                Flexible(
                  flex: 3,
                  child: Tooltip(
                    message: 'Selecione um caderno',
                    child: AppDropDownSimple(
                      onSelected: (value) {
                        if (value.isNull) return;

                        final note = stateNote.notes.firstWhere((n) => n.title.toUpperCase() == value);

                        context.read<LinkBloc>().loadQuestionsByNote(note);
                      },
                      onValidator: (value) {
                        return null;
                      },
                      list: notes.map((n) => n.title.toUpperCase()).toList(),
                      value: state.noteSelected?.title.toUpperCase(),
                      labelText: '',
                      hint: 'Cadernos',
                      enable: true,
                    ),
                  ),
                ),
                Tooltip(
                  message: 'Total de questões vinculadas',
                  child: PanelBoardInfo(
                    icon: Icons.emoji_events,
                    label: 'Questões Vinculadas:',
                    value: '${state.countLinked}/50',
                  ),
                )
              ],
            )
          ],
        );
      },
    );
  }
}
