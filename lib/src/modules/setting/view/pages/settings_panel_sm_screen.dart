import 'package:correcao_cfc/src/ui/appBar/app_bar_simple.dart';
import 'package:correcao_cfc/src/ui/drawer/app_drawer.dart';
import 'package:correcao_cfc/src/ui/global/app_divider.dart';

import '../../../../shared/export/app_export.dart';

class SettingsPanelSmScreen extends StatelessWidget {
  const SettingsPanelSmScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarSimple(),
      drawer: AppDrawer(),
      body: Container(
        padding: EdgeInsets.all(AppInsets.lg),
        margin: EdgeInsets.only(
          bottom: AppInsets.sm,
          left: AppInsets.sm,
          right: AppInsets.sm,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: context.colorScheme.onSecondaryFixedVariant,
          ),
        ),
        child: Column(
          spacing: AppSpacing.med,
          children: [
            AppHeader(
              spacing: AppSpacing.sm,
              title: 'Configurações',
              description:
                  'Gerencie as configurações da aplicação. Altere o caderno referência, habilite exportação dos quadros ou zere os dados para a próxima correção.',
            ),
            AppDivider(),
            Expanded(child: SettingsPanelBody())
          ],
        ),
      ),
    );
  }
}
