import '../../../../shared/export/app_export.dart';

class CompetitorHeaderContentLg extends StatelessWidget {
  const CompetitorHeaderContentLg({super.key});

  @override
  Widget build(BuildContext context) {
    final stateNote = context.watch<NoteBloc>().state;

    return Flex(
      direction: Axis.horizontal,
      spacing: AppSpacing.sm,
      mainAxisSize: MainAxisSize.min,
      children: [
        Flexible(
          flex: 8,
          fit: context.isMobile ? FlexFit.loose : FlexFit.tight,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: AppSpacing.med,
            children: [
              Text(
                'Análise de Concorrentes',
                style: context.theme.textTheme.headlineLarge!.copyWith(
                  color: context.colorScheme.onTertiary,
                ),
              ),
              Text(
                'Insira o gabarito de cada concorrente para cada questão. Linhas com gabaritos idênticos serão destacadas.',
                style: context.theme.textTheme.headlineMedium!.copyWith(
                  color: context.colorScheme.scrim,
                ),
              ),
            ],
          ),
        ),
        Flexible(
          child: AppDropDownSimple(
            onSelected: (value) {
              if (value.isNull) return;

              final note = stateNote.notes.firstWhere((n) => n.title.toUpperCase() == value);

              context.read<CompetitorBloc>().load(note.id);
            },
            onValidator: (value) => null,
            list: [
              'TIPO 1',
              'TIPO 2',
              'TIPO 3',
              'TIPO 4',
            ],
            labelText: '',
            hint: '',
            enable: true,
            value: stateNote.reference!.title.toUpperCase(),
          ),
        ),
      ],
    );
  }
}
