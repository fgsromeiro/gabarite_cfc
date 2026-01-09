import '../../shared/export/app_export.dart';

class AppError extends StatelessWidget {
  const AppError({
    required this.message,
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.error_outline,
            size: 60,
            color: Colors.red,
          ),
          const SizedBox(height: 30),
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
