import '../../shared/export/app_export.dart';

class AppListEmpty extends StatelessWidget {
  const AppListEmpty({
    required this.message,
    this.isCentered = true,
    super.key,
  });

  final String message;
  final bool isCentered;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Icon(
            Icons.manage_search,
            color: context.colorScheme.secondary,
            size: AppIconSizes.iconXl,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              'Sem itens para exibir',
              textAlign: TextAlign.center,
              style: context.theme.textTheme.titleMedium!.copyWith(color: context.colorScheme.secondary),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Text(
              message,
              textAlign: TextAlign.center,
              style: context.theme.textTheme.titleMedium!.copyWith(color: context.colorScheme.onSecondaryFixedVariant),
            ),
          ),
        ],
      ),
    );
  }
}
