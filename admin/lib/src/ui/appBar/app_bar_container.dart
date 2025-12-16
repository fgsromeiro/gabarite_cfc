import '../../shared/export/app_export.dart';

class AppBarContainer extends StatelessWidget {
  const AppBarContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.sz.height * 0.1,
      alignment: Alignment.centerLeft,
      child: Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Image.asset(
            ImageConstants.logoCorrecao,
            scale: 12,
          ),
          BlocBuilder<NoteBloc, NoteState>(
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
                      color: context.colorScheme.secondary.withAlpha(40),
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
                          style: context.theme.textTheme.headlineSmall!.copyWith(color: context.colorScheme.secondary),
                        ),
                      ],
                    ),
                  ),
                );
              }
              return SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}
