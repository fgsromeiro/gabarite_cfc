// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class PanelLinkSmCard extends StatelessWidget with ApplicationGlobalMixin {
  const PanelLinkSmCard({
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
        questionReference = getQustionBaseReference(
          id: question.idQuestionBase,
          listOfQuestionsBase: state.questionsRefs,
        );

        return GestureDetector(
          onTap: () {
            if (question.idQuestionBase.isNotEmpty) {
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
            } else {
              Dialogs.showDialogSelectQuestionToLink(
                context,
                state.listOfIdQuestionsLinked,
              ).then(
                (questionBase) {
                  if (questionBase.isNull) return;

                  if (!context.mounted) return;

                  context.read<LinkBloc>().link(questionBase!, question.id, question.index);
                },
              );
            }
          },
          child: Stack(
            children: [
              Container(
                padding: EdgeInsets.all(AppInsets.sm),
                margin: EdgeInsets.only(bottom: AppInsets.sm),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: question.idQuestionBase.isEmpty
                        ? context.colorScheme.onSecondaryFixedVariant
                        : context.colorScheme.onPrimary,
                  ),
                ),
                width: double.infinity,
                child: Column(
                  spacing: AppSpacing.sm,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      mainAxisAlignment: MainAxisAlignment.start,
                      spacing: AppSpacing.xs,
                      children: [
                        BoardPanelLabelCard(value: "Q${question.index}", icon: Icons.numbers),
                        AppDot(),
                        BoardPanelLabelCard(
                            icon: Icons.check_box_outlined, value: mapperTextAlternative(question.alternative)),
                      ],
                    ),
                    BoardPanelLabelCard(
                      icon: Icons.note_alt_outlined,
                      value: question.enunciated,
                    ),
                    BoardPanelLabelCard(
                      icon: Icons.insert_drive_file_outlined,
                      value: question.textAlternative,
                    ),
                    if (questionReference.isNotNull)
                      BoardPanelLabelCard(
                        icon: Icons.link,
                        value: questionReference!.title,
                      ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    question.idQuestionBase.isEmpty ? Icons.link : Icons.link_off,
                    color: question.idQuestionBase.isEmpty
                        ? context.colorScheme.onSecondaryFixedVariant
                        : context.colorScheme.onPrimary,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
