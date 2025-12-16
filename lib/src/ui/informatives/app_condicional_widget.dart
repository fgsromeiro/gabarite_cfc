import '../../shared/export/app_export.dart';

class AppConditionalWidget extends StatelessWidget {
  final bool condition;
  final Widget firstChild;
  final Widget secondChild;

  const AppConditionalWidget({
    required this.condition,
    required this.firstChild,
    required this.secondChild,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return condition ? firstChild : secondChild;
  }
}
