import '../../../../shared/export/app_export.dart';

class MenuListTile extends StatefulWidget {
  MenuListTile({
    super.key,
    required this.title,
    required this.icon,
    required this.onPressed,
    required this.isSelected,
    required this.enable,
    this.trailing = Icons.arrow_forward_ios,
  });

  final String title;
  final IconData icon;
  IconData? trailing;
  final VoidCallback onPressed;
  final bool isSelected;
  final bool enable;

  @override
  State<MenuListTile> createState() => _MenuListTileState();
}

class _MenuListTileState extends State<MenuListTile> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: widget.enable,
      child: GestureDetector(
        onTap: widget.onPressed,
        child: MouseRegion(
          onEnter: (_) => setState(() => isHovered = true),
          onExit: (_) => setState(() => isHovered = false),
          child: AnimatedContainer(
            duration: Duration(milliseconds: 150),
            height: context.sz.height * 0.1,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: _buildColor(
                context,
                isSelected: widget.isSelected,
                isHovered: isHovered,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ListTile(
              horizontalTitleGap: 30,
              leading: Icon(
                widget.icon,
                size: 23,
                color: context.colorScheme.onTertiary,
              ),
              title: Text(
                widget.title,
                style: context.theme.textTheme.headlineSmall!.copyWith(
                  color: context.colorScheme.onTertiary,
                ),
              ),
              trailing: Icon(
                widget.enable ? widget.trailing : Icons.https,
                size: 15,
                color: widget.isSelected ? context.colorScheme.onTertiary : context.colorScheme.scrim,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Color _buildColor(
    BuildContext context, {
    required bool isSelected,
    required bool isHovered,
  }) {
    if (isSelected || isHovered) return context.colorScheme.primary.withAlpha(40);

    return AppColors.transparent;
  }
}
