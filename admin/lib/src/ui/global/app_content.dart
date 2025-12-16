import '../../shared/export/app_export.dart';

class AppContent extends StatelessWidget {
  const AppContent({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: EdgeInsets.all(AppInsets.lg),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadius.lg),
          border: Border.all(
            color: context.colorScheme.onSecondaryFixedVariant,
          ),
        ),
        child: child,
      ),
    );
  }
}
