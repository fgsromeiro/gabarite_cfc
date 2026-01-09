import '../../../../../shared/export/app_export.dart';

class PanelLinkCard extends StatelessWidget with ApplicationGlobalMixin {
  PanelLinkCard({
    super.key,
    required this.question,
    required this.enable,
  });

  final TBL0002 question;
  final bool enable;

  @override
  Widget build(BuildContext context) {
    TBL0003? questionReference;

    return BlocBuilder<LinkBloc, LinkState>(
      builder: (context, state) {
        questionReference =
            getQustionBaseReference(id: question.idQuestionBase, listOfQuestionsBase: state.questionsRefs);
        return Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppInsets.med),
          decoration: BoxDecoration(
            border: Border.all(
              color: question.idQuestionBase.isEmpty
                  ? context.colorScheme.onSecondaryFixedVariant
                  : context.colorScheme.onPrimary,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(AppRadius.lg),
          ),
          margin: EdgeInsets.only(bottom: AppInsets.med),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 15,
            children: [
              Stack(
                alignment: Alignment.centerRight,
                children: [
                  Flex(
                    direction: Axis.horizontal,
                    children: [
                      BoardPanelLabelCard(
                        icon: Icons.numbers,
                        value: question.title.toUpperCase(),
                      ),
                      AppDot(),
                      BoardPanelLabelCard(
                        icon: Icons.check_box_outlined,
                        label: 'Alternativa:',
                        value: mapperTextAlternative(question.alternative),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.all(AppInsets.sm),
                    decoration: BoxDecoration(
                      color: question.idQuestionBase.isEmpty
                          ? context.colorScheme.onSecondaryFixedVariant
                          : context.colorScheme.onPrimary,
                      borderRadius: BorderRadius.circular(AppRadius.full),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      spacing: AppSpacing.sm,
                      children: [
                        Icon(
                          question.idQuestionBase.isEmpty ? Icons.info_outline : Icons.check_circle_outlined,
                          color: context.colorScheme.onTertiary,
                        ),
                        Text(
                          question.idQuestionBase.isEmpty ? 'Não Vinculada' : 'Vinculada',
                          style: context.theme.textTheme.headlineSmall!.copyWith(color: context.colorScheme.onTertiary),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              BoardPanelLabelCard(
                icon: Icons.note_alt_outlined,
                label: 'Enunciado:',
                value: question.enunciated,
              ),
              BoardPanelLabelCard(
                icon: Icons.insert_drive_file_outlined,
                label: 'Texto da alternativa:',
                value: question.textAlternative,
              ),
              if (questionReference.isNotNull)
                BoardPanelLabelCard(
                  icon: Icons.link,
                  label: 'Vinculada:',
                  value: questionReference!.title,
                ),
              Visibility(
                visible: enable,
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    spacing: AppSpacing.sm,
                    children: [
                      Visibility(
                        visible: question.idQuestionBase.isEmpty,
                        child: AppIconButton(
                          tooltipMessage: 'Vincular questão',
                          icon: Icons.link,
                          borderColor: context.colorScheme.onSecondaryFixedVariant,
                          overlayColor: context.colorScheme.secondary,
                          backgroundColor: context.colorScheme.surface,
                          color: context.colorScheme.onSecondaryFixedVariant,
                          onPressed: () {
                            Dialogs.showDialogAnimated<TBL0003>(
                              context,
                              dialog: PanelLinkDialog(questionsLinked: state.listOfIdQuestionsLinked),
                            ).then(
                              (questionBase) {
                                if (questionBase.isNull) return;

                                if (!context.mounted) return;

                                context.read<LinkBloc>().link(questionBase!, question.id, question.index);
                              },
                            );
                          },
                        ),
                      ),
                      Visibility(
                        visible: question.idQuestionBase.isNotEmpty && !state.noteSelected!.isReference,
                        child: AppIconButton(
                          tooltipMessage: 'Remover vínculo',
                          icon: Icons.close,
                          borderColor: context.colorScheme.onSecondaryFixedVariant,
                          overlayColor: context.colorScheme.secondary,
                          backgroundColor: context.colorScheme.surface,
                          color: context.colorScheme.onSecondaryFixedVariant,
                          onPressed: () {
                            Dialogs.showDialogAction(
                              context: context,
                              title: 'Deseja remover o vínculo desta questão?',
                              description:
                                  'Isso irá desvincular ${question.title}. O conteúdo da questão comum será apagado. Deseja continuar?',
                              titleAction: 'Remover',
                              onPressed: () {
                                context.read<LinkBloc>().removeLink(question);
                              },
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
