import '../../../../shared/export/app_export.dart';

class SettingsPanel extends StatelessWidget {
  const SettingsPanel({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: AppSpacing.sm,
      children: [
        AppHeader(
          spacing: AppSpacing.sm,
          title: 'Configurações',
          description:
              'Gerencie as configurações da aplicação. Altere o caderno referência, habilite exportação dos quadros ou zere os dados para a próxima correção.',
        ),
        AppDivider(),
        SettingsPanelBody()
      ],
    );
  }
}
