import 'package:correcao_cfc/src/shared/export/app_export.dart';

class AppBarSimple extends StatelessWidget implements PreferredSizeWidget {
  const AppBarSimple({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Image.asset(
        ImageConstants.logoCorrecao,
        scale: AppIconSizes.iconSm,
      ),
      actionsPadding: EdgeInsets.only(right: AppInsets.med),
      actions: [
        BlocBuilder<NoteBloc, NoteState>(
          builder: (context, state) {
            return Container(
              padding: EdgeInsets.all(AppInsets.xs),
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
                  AnimatedCrossFade(
                    duration: Duration(milliseconds: 800),
                    crossFadeState: state.status.isLoading ? CrossFadeState.showFirst : CrossFadeState.showSecond,
                    firstChild: Container(
                      width: 20,
                      height: 20,
                      padding: EdgeInsets.all(2),
                      child: AppCircularIndicator(),
                    ),
                    secondChild: Text(
                      '${state.reference?.title.toUpperCase()} ',
                      style: context.theme.textTheme.headlineSmall!.copyWith(color: context.colorScheme.secondary),
                    ),
                  ),
                ],
              ),
            );
          },
        )
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
