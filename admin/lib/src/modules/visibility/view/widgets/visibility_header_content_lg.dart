import '../../../../shared/export/app_export.dart';

class VisibilityHeaderContentLg extends StatelessWidget {
  const VisibilityHeaderContentLg({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final url = 'https://board-gabarite-cfc.globeapp.dev';
    final permission = context.read<MenuBloc>().state.permission;

    return BlocBuilder<VisibilityBloc, VisibilityState>(
      builder: (context, state) {
        return Flex(
          direction: Axis.horizontal,
          spacing: AppSpacing.med,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: AppSpacing.med,
                children: [
                  Text(
                    'Exibir Gabarito',
                    style: context.theme.textTheme.headlineLarge!.copyWith(
                      color: context.colorScheme.onTertiary,
                    ),
                  ),
                  Text(
                    'Visualize os vínculos entre as questões de todos os cadernos e controle a exibição no painel.',
                    style: context.theme.textTheme.headlineMedium!.copyWith(
                      color: context.colorScheme.scrim,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              spacing: AppSpacing.sm,
              children: [
                if (permission.isAdmin)
                  AppIconButton(
                    tooltipMessage: 'Abrir quadro',
                    borderColor: context.colorScheme.onSecondaryFixedVariant,
                    icon: Icons.call_made,
                    onPressed: () {
                      final uri = Uri.parse(url);
                      launchUrl(uri, webOnlyWindowName: '_blank');
                    },
                    backgroundColor: context.colorScheme.surface,
                    overlayColor: context.colorScheme.secondary,
                    color: context.colorScheme.onSecondaryFixedVariant,
                  ),
                AppIconButton(
                  tooltipMessage: 'Sincronizar questões',
                  overlayColor: context.colorScheme.secondary,
                  borderColor: context.colorScheme.onSecondaryFixedVariant,
                  icon: Icons.refresh,
                  onPressed: () => context.read<VisibilityBloc>()..load(),
                  backgroundColor: context.colorScheme.surface,
                  color: context.colorScheme.onSecondaryFixedVariant,
                ),
                if (permission.isAdmin)
                  AppIconButton(
                    borderColor: context.colorScheme.onSecondaryFixedVariant,
                    overlayColor: context.colorScheme.secondary,
                    tooltipMessage: state.isVisilityAll ? 'Esconder todas as questões' : 'Exibir todas as questões',
                    icon: state.isVisilityAll ? Icons.visibility_off : Icons.visibility,
                    onPressed: state.isVisilityAll
                        ? () {
                            Dialogs.showDialogAction(
                              context: context,
                              title: 'Esconder Questões',
                              description: 'Deseja esconder as questões no quadro?',
                              titleAction: 'Esconder',
                              onPressed: () => context.read<VisibilityBloc>().onVisibilityAll(false),
                            );
                          }
                        : () {
                            Dialogs.showDialogAction(
                              context: context,
                              title: 'Exibir Questões',
                              description: 'Deseja exibir as questões no quadro?',
                              titleAction: 'Exibir',
                              onPressed: () => context.read<VisibilityBloc>().onVisibilityAll(true),
                            );
                          },
                    backgroundColor: context.colorScheme.surface,
                    color: context.colorScheme.onSecondaryFixedVariant,
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}
