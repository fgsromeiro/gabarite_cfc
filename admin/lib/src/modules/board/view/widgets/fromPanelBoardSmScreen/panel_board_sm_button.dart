import 'package:gabarite_cfc/src/shared/export/app_export.dart';

class PanelBoardSmButton extends StatelessWidget {
  const PanelBoardSmButton({super.key, required this.onTap, required this.icon, this.showBadge});

  final VoidCallback onTap;
  final IconData icon;
  final bool? showBadge;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: AlignmentDirectional.topEnd,
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(AppRadius.md),
              border: Border.all(
                color: context.colorScheme.onSecondaryFixedVariant,
              ),
            ),
            child: Center(
              child: Icon(
                icon,
                color: context.colorScheme.onSecondaryFixedVariant,
                size: AppIconSizes.iconMd,
              ),
            ),
          ),
        ),
        if (showBadge == true)
          Positioned(
            child: Container(
              width: 15,
              height: 15,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: context.colorScheme.error,
              ),
            ),
          )
      ],
    );
  }
}
