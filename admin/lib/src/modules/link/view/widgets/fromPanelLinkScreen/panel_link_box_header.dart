import '../../../../../shared/export/app_export.dart';

class PanelLinkBoxHeader extends StatefulWidget {
  const PanelLinkBoxHeader({super.key});

  @override
  State<PanelLinkBoxHeader> createState() => _PanelLinkBoxHeaderState();
}

class _PanelLinkBoxHeaderState extends State<PanelLinkBoxHeader> {
  late final TextEditingController _controller;
  late final LinkBloc _bloc;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _bloc = context.read<LinkBloc>();
  }

  @override
  Widget build(BuildContext context) {
    String? noteSelected;
    final stateNote = context.watch<NoteBloc>().state;
    final notes = stateNote.notes.where((n) => !n.isReference).toList();

    return BlocBuilder<LinkBloc, LinkState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: AppSpacing.med,
            children: [
              AppHeader(
                title: 'Vínculo de Questões',
                spacing: AppSpacing.med,
                description:
                    'Selecione uma questão de cada lado para criar um vínculo. Cada questão de referência só pode ter um vínculo por caderno.',
              ),
              Row(
                spacing: AppSpacing.sm,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 7,
                    child: AppTextFormField(
                      textInputFormatter: [
                        FilteringTextInputFormatter.allow(RegExp(r'^[0-9\s]+$')),
                      ],
                      labelText: '',
                      hintText: 'Informe o número da questão',
                      prefix: Icon(
                        Icons.search,
                        color: context.colorScheme.onPrimaryFixedVariant,
                      ),
                      controller: _controller,
                      onChanged: (value) {
                        if (value.isNull) return;

                        _bloc.search(value);
                      },
                      validator: (p0) {
                        return null;
                      },
                    ),
                  ),
                  Expanded(
                    flex: 3,
                    child: Tooltip(
                      message: 'Selecione um caderno',
                      child: AppDropDownSimple(
                        onSelected: (value) {
                          if (value.isNull) return;

                          noteSelected = value;

                          final note = stateNote.notes.firstWhere((n) => n.title.toUpperCase() == value);

                          context.read<LinkBloc>().loadQuestionsByNote(note);
                        },
                        onValidator: (value) {
                          return null;
                        },
                        list: notes.map((n) => n.title.toUpperCase()).toList(),
                        value: noteSelected,
                        labelText: '',
                        hint: 'Cadernos',
                        enable: true,
                      ),
                    ),
                  ),
                  Tooltip(
                    message: 'Total de questões vinculadas',
                    child: BoardPanelInfo(
                      icon: Icons.emoji_events,
                      label: 'Questões Vinculadas:',
                      value: '${state.countLinked}/50',
                    ),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }
}
