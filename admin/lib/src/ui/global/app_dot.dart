import '../../shared/export/app_export.dart';

class AppDot extends StatelessWidget {
  const AppDot({
    super.key,
    this.color,
  });

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 5,
      width: 5,
      decoration: BoxDecoration(
        color: color ?? context.colorScheme.onSecondaryFixedVariant,
        shape: BoxShape.circle,
      ),
    );
  }
}
