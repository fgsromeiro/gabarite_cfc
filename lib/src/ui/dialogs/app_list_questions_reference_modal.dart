import 'package:correcao_cfc/src/shared/export/app_export.dart';

class AppListQuestionsReferenceModal extends StatefulWidget {
  const AppListQuestionsReferenceModal({
    super.key,
    required this.value,
  });

  final List<String> value;

  @override
  State<AppListQuestionsReferenceModal> createState() => _CalculatorSearchNCMModalState();
}

class _CalculatorSearchNCMModalState extends State<AppListQuestionsReferenceModal> {
  late final BoardBloc _bloc;
  Map<TBL0003, bool> itens = {};

  @override
  void initState() {
    super.initState();
    _bloc = context.read<BoardBloc>();
    _bloc.load();
  }

  @override
  Widget build(BuildContext context) {
    final noteState = context.watch<NoteBloc>().state;

    return Container(
      padding: EdgeInsets.only(
        left: 16.0,
        right: 16.0,
        top: 16.0,
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  // "${noteState.reference?.title} como referência",
                  "TIPO 1 como referência",
                  style: context.theme.textTheme.headlineMedium!.copyWith(color: context.colorScheme.onTertiary),
                ),
              ),
              IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  color: Colors.grey,
                ),
              )
            ],
          ),
          BlocBuilder<BoardBloc, BoardState>(
            bloc: context.read<BoardBloc>()..load(),
            builder: (context, state) {
              _mapper(
                widget.value,
                state.listOfQuestionsAll,
              );

              if (state.status.isLoading) {
                return AppCircularIndicator();
              }

              return Expanded(
                child: ListView.builder(
                  itemCount: itens.length,
                  itemBuilder: (context, index) {
                    final key = itens.keys.elementAt(index);
                    final value = itens.values.elementAt(index);

                    return _lineDialog(
                      context,
                      question: key,
                      isSelected: value,
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }

  Widget _lineDialog(
    BuildContext context, {
    required TBL0003 question,
    required bool isSelected,
  }) {
    bool isHovered = false;
    return StatefulBuilder(
      builder: (context, setState) => GestureDetector(
        onTap: isSelected ? null : () => Navigator.pop(context, question),
        child: MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: Container(
            padding: EdgeInsets.all(AppInsets.lg),
            margin: EdgeInsets.symmetric(vertical: AppInsets.sm),
            decoration: BoxDecoration(
                color: isHovered && !isSelected ? context.colorScheme.scrim.withAlpha(55) : null,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: isSelected ? null : Border.all(color: context.colorScheme.onSecondaryFixedVariant)),
            child: Opacity(
              opacity: isSelected ? 0.5 : 1,
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: AppSpacing.sm,
                      children: [
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${question.index}) ',
                                style: context.theme.textTheme.headlineSmall!.copyWith(
                                  color: context.colorScheme.onSecondaryFixedVariant,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: question.isFilled ? question.enunciated : 'Não respondida',
                                style: context.theme.textTheme.headlineSmall!.copyWith(
                                  color: context.colorScheme.onTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: question.isFilled,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            spacing: AppSpacing.xs,
                            children: [
                              Icon(
                                Icons.check_box_outlined,
                                color: context.colorScheme.onSecondaryFixedVariant,
                              ),
                              Text(
                                '${question.alternative}) ${question.alternative}',
                                style: context.theme.textTheme.headlineSmall!.copyWith(
                                  color: context.colorScheme.onTertiary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: isSelected,
                    child: Text(
                      'Vinculada',
                      style: context.theme.textTheme.headlineSmall!
                          .copyWith(color: context.colorScheme.onSecondaryFixedVariant, fontStyle: FontStyle.italic),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _mapper(
    List<String> ids,
    List<TBL0003> questionsBase,
  ) {
    for (var question in questionsBase) {
      if (!ids.any((q) => q == question.id)) {
        itens.addAll({question: false});
      }
    }
  }
}
