import 'package:correcao_cfc/src/shared/export/app_export.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({super.key, this.color = AppColors.blue400, this.showPoint = true});

  final Color color;
  final bool showPoint;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Divider(
            color: color,
          ),
        ),
        Visibility(
          visible: showPoint,
          child: Container(
            height: 6,
            width: 6,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: color,
            ),
          ),
        )
      ],
    );
  }
}
