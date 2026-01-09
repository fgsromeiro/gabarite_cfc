import '../../shared/export/app_export.dart';

class AppCircularIndicator extends StatelessWidget {
  const AppCircularIndicator({super.key, this.color});

  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color ?? context.colorScheme.secondary,
      ),
    );
  }
}
