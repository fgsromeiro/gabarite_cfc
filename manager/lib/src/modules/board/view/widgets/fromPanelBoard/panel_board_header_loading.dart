import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class PanelBoardHeaderLoading extends StatelessWidget {
  const PanelBoardHeaderLoading({super.key});

  @override
  Widget build(BuildContext context) {
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
              child: ContainerPlaceholder(
                height: 50,
                width: double.infinity,
              ),
            ),
            Flexible(
              flex: 2,
              child: ContainerPlaceholder(
                height: 50,
                width: double.infinity,
              ),
            ),
            Flexible(
              flex: 3,
              child: ContainerPlaceholder(
                height: 50,
                width: double.infinity,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
