import '../../shared/export/app_export.dart';

class AppBarContainer extends StatelessWidget {
  AppBarContainer({super.key, this.showBackButton});

  bool? showBackButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.sz.height * 0.1,
      alignment: Alignment.centerLeft,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.start,
        spacing: AppSpacing.sm,
        children: [
          if (showBackButton == true)
            AppIconButton(
              icon: Icons.arrow_back,
              onPressed: () => Navigator.pushReplacementNamed(context, AppRoutesSchema.initial),
              tooltipMessage: 'Voltar à página anterior',
            ),
          Image.asset(
            ImageConstants.logoGabariteCFCExtends,
            // scale: 12,
          ),
          Expanded(
            child: Align(
              alignment: Alignment.centerRight,
              child: BlocBuilder<NoteBloc, NoteState>(
                builder: (context, state) {
                  if (state.status.isLoading) {
                    return ContainerPlaceholder(
                      width: context.sz.width * 0.25,
                      height: context.sz.height * 0.1,
                    );
                  }
                  if ((state.status.isLoaded || state.status.isUpdated) && state.reference.isNotNull) {
                    return Tooltip(
                      message: 'Caderno de questão selecionado como referência',
                      child: Container(
                        padding: EdgeInsets.all(AppInsets.sm),
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary.withAlpha(60),
                          borderRadius: BorderRadius.circular(AppRadius.full),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          spacing: AppSpacing.xs,
                          children: [
                            Icon(
                              Icons.star,
                              color: context.colorScheme.secondary,
                            ),
                            Text(
                              '${state.reference?.title.toUpperCase()} como referência',
                              style:
                                  context.theme.textTheme.headlineSmall!.copyWith(color: context.colorScheme.secondary),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
