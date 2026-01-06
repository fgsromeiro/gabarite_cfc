import '../../../../../shared/export/app_export.dart';

class PanelBoardEditLine extends StatelessWidget with ApplicationGlobalMixin {
  const PanelBoardEditLine({
    super.key,
    required this.question,
    required this.indexJump,
  });

  final TBL0003 question;
  final int indexJump;

  @override
  Widget build(BuildContext context) {
    bool isHovered = false;
    final permission = context.read<MenuBloc>().state.permission;

    return StatefulBuilder(
      builder: (context, setState) => GestureDetector(
        onTap: () async {
          if (permission.isProducts) {
            Dialogs.showDialogMessage(
              context,
              message: 'Você não tem permissão para editar esta questão.',
              color: context.colorScheme.error,
            );
          } else {
            await showDialog<void>(
              context: context,
              barrierDismissible: false,
              builder: (context) {
                return PanelBoardEditLineDialog(
                  question: question,
                );
              },
            );
          }
        },
        child: MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppInsets.med),
            decoration: BoxDecoration(
              color: isHovered ? context.colorScheme.scrim.withAlpha(55) : null,
              border: Border.all(
                  color:
                      question.isFilled ? context.colorScheme.onPrimary : context.colorScheme.onSecondaryFixedVariant),
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
                          icon: Icons.person,
                          label: 'Corrigido por:',
                          value: question.teacher,
                        ),
                        AppDot(),
                        BoardPanelLabelCard(
                          icon: Icons.check_box_outlined,
                          label: 'Alternativa:',
                          value: question.alternative,
                        ),
                      ],
                    ),
                    PanelBoardInfoStatus(isFinished: question.isFilled),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
