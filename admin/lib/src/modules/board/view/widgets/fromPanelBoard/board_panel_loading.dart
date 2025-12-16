import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class BoardPanelLoading extends StatelessWidget {
  const BoardPanelLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ContainerPlaceholder(
              height: 50,
              width: 200,
            ),
            ContainerPlaceholder(
              height: 50,
              width: 200,
            ),
          ],
        ),
        Padding(
          padding: EdgeInsets.only(top: AppInsets.lg),
          child: ContainerPlaceholder(
            width: double.infinity,
            height: context.sz.height * 0.3,
          ),
        ),
      ],
    );
  }
}
