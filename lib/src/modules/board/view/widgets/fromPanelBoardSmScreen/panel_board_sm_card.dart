// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:correcao_cfc/src/shared/export/app_export.dart';

class PanelBoardSmCard extends StatelessWidget {
  const PanelBoardSmCard({
    super.key,
    required this.question,
    required this.indexJump,
  });

  final TBL0003 question;
  final int indexJump;

  @override
  Widget build(BuildContext context) {
    final permission = context.read<MenuBloc>().state.permission;
    return GestureDetector(
      onTap: () {
        if (permission.isProducts) {
          Dialogs.showDialogMessage(
            context,
            message: 'Você não tem permissão para editar esta questão.',
            color: context.colorScheme.error,
          );
        } else {
          Navigator.pushNamed(context, AppRoutesSchema.boardFormSmScreen, arguments: question);
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
                color: question.isFilled ? context.colorScheme.onPrimary : context.colorScheme.onSecondaryFixedVariant,
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
                    BoardPanelLabelCard(value: question.teacher, icon: Icons.person),
                    AppDot(),
                    BoardPanelLabelCard(icon: Icons.check_box_outlined, value: question.alternative),
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
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(
                question.isFilled ? Icons.check_circle_outlined : Icons.info_outline,
                color: question.isFilled ? context.colorScheme.onPrimary : context.colorScheme.onTertiary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
