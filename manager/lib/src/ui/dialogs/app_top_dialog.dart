import '../../shared/export/app_export.dart';

class AppTopDialog extends StatefulWidget {
  final String message;
  final Duration duration;
  final VoidCallback onDismiss;
  final Color backgroundColor;

  const AppTopDialog({
    super.key,
    required this.message,
    required this.duration,
    required this.onDismiss,
    required this.backgroundColor,
  });

  @override
  State<AppTopDialog> createState() => _AppTopDialogState();
}

class _AppTopDialogState extends State<AppTopDialog> with SingleTickerProviderStateMixin {
  late AnimationController _slideController;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _slideController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 450),
    );

    _slideAnimation = Tween<Offset>(
      begin: Offset(5, 0),
      end: Offset(0, 0),
    ).animate(CurvedAnimation(
      parent: _slideController,
      curve: Curves.easeIn,
      reverseCurve: Curves.easeOut,
    ));

    _slideController.forward();

    Future.delayed(
      widget.duration,
      () async {
        await _slideController.reverse();
        widget.onDismiss();
      },
    );
  }

  @override
  void dispose() {
    _slideController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: MediaQuery.of(context).padding.top + 15,
      right: 16,
      child: SlideTransition(
        position: _slideAnimation,
        child: Material(
          elevation: 8,
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Container(
            constraints: BoxConstraints(maxWidth: 300.0),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: widget.backgroundColor,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Flex(
              direction: Axis.horizontal,
              mainAxisSize: MainAxisSize.min,
              spacing: AppSpacing.med,
              children: [
                Icon(
                  Icons.info_outline,
                  color: context.theme.colorScheme.onTertiary,
                ),
                Expanded(
                  child: Text(
                    widget.message,
                    style: context.theme.textTheme.titleMedium?.copyWith(
                      color: context.theme.colorScheme.onTertiary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
