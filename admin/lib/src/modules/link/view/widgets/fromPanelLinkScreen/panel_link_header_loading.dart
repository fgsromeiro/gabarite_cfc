import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class PanelLinkHeaderLoading extends StatelessWidget {
  const PanelLinkHeaderLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
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
