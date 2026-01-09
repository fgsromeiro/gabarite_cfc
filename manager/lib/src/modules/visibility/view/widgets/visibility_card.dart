import '../../../../shared/export/app_export.dart';

class VisibilityCard extends StatelessWidget with ApplicationGlobalMixin {
  VisibilityCard({
    super.key,
    required this.visibility,
  });

  final QuestionVisibility visibility;

  @override
  Widget build(BuildContext context) {
    final permission = context.read<MenuBloc>().state.permission;

    return BlocBuilder<VisibilityBloc, VisibilityState>(
      builder: (context, state) {
        return GestureDetector(
          onTap: context.isMobile
              ? () => context.read<VisibilityBloc>().onVisibility(visibility, !visibility.isVisible)
              : null,
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(
              horizontal: context.sz.width * 0.02,
              vertical: context.sz.height * 0.04,
            ),
            decoration: BoxDecoration(
              color: visibility.isVisible ? context.colorScheme.primary.withValues(alpha: 230) : null,
              border: Border.all(
                color: visibility.isVisible ? context.colorScheme.primary : context.colorScheme.onSecondaryFixedVariant,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            margin: EdgeInsets.only(bottom: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 15,
              children: [
                BoardPanelLabelCard(
                  icon: Icons.numbers,
                  label: 'QUESTÃO',
                  value: visibility.questionBase.index.toString(),
                  color: context.colorScheme.onTertiary,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Flex(
                    direction: Axis.horizontal,
                    spacing: AppSpacing.sm,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Tooltip(
                        message: 'Questão vinculada no caderno Tipo 1',
                        child: BoardPanelLabelCard(
                          icon: Icons.book,
                          label: 'TIPO 1:',
                          value: visibility.indexTypeOne.isNotNull ? 'Questão ${visibility.indexTypeOne}' : 'S/N',
                          isBorder: true,
                          color: AppColors.backgroundNoteOne,
                        ),
                      ),
                      Tooltip(
                        message: 'Questão vinculada no caderno Tipo 2',
                        child: BoardPanelLabelCard(
                          icon: Icons.book,
                          label: 'TIPO 2:',
                          value: visibility.indexTypeTwo.isNotNull ? 'Questão ${visibility.indexTypeTwo}' : 'S/N',
                          isBorder: true,
                          color: AppColors.backgroundNoteTwo,
                        ),
                      ),
                      Tooltip(
                        message: 'Questão vinculada no caderno Tipo 3',
                        child: BoardPanelLabelCard(
                          icon: Icons.book,
                          label: 'TIPO 3:',
                          value: visibility.indexTypeThree.isNotNull ? 'Questão ${visibility.indexTypeThree}' : 'S/N',
                          isBorder: true,
                          color: AppColors.backgroundNoteThree,
                        ),
                      ),
                      Tooltip(
                        message: 'Questão vinculada no caderno Tipo 4',
                        child: BoardPanelLabelCard(
                          icon: Icons.book,
                          label: 'TIPO 4:',
                          value: visibility.indexTypeFour.isNotNull ? 'Questão ${visibility.indexTypeFour}' : 'S/N',
                          isBorder: true,
                          color: AppColors.backgroundNoteFour,
                        ),
                      )
                    ],
                  ),
                ),
                Divider(
                  color: context.colorScheme.onSecondaryFixedVariant,
                ),
                Flex(
                  direction: Axis.horizontal,
                  spacing: AppSpacing.sm,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BoardPanelLabelCard(
                            icon: Icons.note_alt_outlined,
                            label: 'Enunciado:',
                            value: visibility.questionBase.enunciated,
                          ),
                          BoardPanelLabelCard(
                            icon: Icons.person,
                            label: 'Corrigido por:',
                            value: visibility.questionBase.teacher,
                          ),
                          BoardPanelLabelCard(
                            icon: Icons.type_specimen,
                            label: 'Alternativa:',
                            value: visibility.questionBase.alternative,
                          ),
                          BoardPanelLabelCard(
                            icon: Icons.type_specimen,
                            label: 'Texto Alternativa:',
                            value: visibility.questionBase.textAlternative,
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: (permission.isAdmin || permission.isModerator) && !context.isMobile,
                      child: Tooltip(
                        message: visibility.isVisible
                            ? 'Ocultar alternativa no quadro de correção'
                            : 'Exibir alternativa no quadro de correção',
                        child: AppSwitchButton(
                          active: visibility.isVisible,
                          onChanged: (value) => context.read<VisibilityBloc>().onVisibility(visibility, value),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
