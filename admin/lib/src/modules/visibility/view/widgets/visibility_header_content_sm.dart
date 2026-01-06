import '../../../../shared/export/app_export.dart';

class VisibilityHeaderContentSm extends StatelessWidget {
  const VisibilityHeaderContentSm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final url = 'https://quadro-correcao-cfc.globeapp.dev';
    final permission = context.read<MenuBloc>().state.permission;

    return BlocBuilder<VisibilityBloc, VisibilityState>(
      builder: (context, state) {
        return Flex(
          direction: Axis.horizontal,
          crossAxisAlignment: CrossAxisAlignment.start,
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
            if (context.isMobile)
              PopupMenuButton(
                itemBuilder: (context) {
                  return [
                    if (permission.isAdmin && !context.isMobile)
                      PopupMenuItem(
                        onTap: () {
                          final uri = Uri.parse(url);
                          launchUrl(uri, webOnlyWindowName: '_blank');
                        },
                        child: Text(
                          'Abrir quadro',
                          style: context.theme.textTheme.headlineSmall!.copyWith(
                            color: context.colorScheme.onTertiary,
                          ),
                        ),
                      ),
                    PopupMenuItem(
                      onTap: () => context.read<VisibilityBloc>()..load(),
                      child: Text(
                        'Sincronizar questões',
                        style: context.theme.textTheme.headlineSmall!.copyWith(
                          color: context.colorScheme.onTertiary,
                        ),
                      ),
                    ),
                    if (permission.isAdmin)
                      PopupMenuItem(
                        onTap: state.isVisilityAll
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
                        child: Text(
                          state.isVisilityAll ? 'Esconder todas as questões' : 'Exibir todas as questões',
                          style: context.theme.textTheme.headlineSmall!.copyWith(
                            color: context.colorScheme.onTertiary,
                          ),
                        ),
                      ),
                  ];
                },
              ),
          ],
        );
      },
    );
  }
}
