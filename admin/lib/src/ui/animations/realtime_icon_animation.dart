import '../../shared/export/app_export.dart';

class RealtimeIconAnimation extends StatefulWidget {
  final double size;
  final Color color;
  final bool isActive;

  const RealtimeIconAnimation({
    super.key,
    this.size = 24.0,
    this.color = Colors.green,
    this.isActive = true,
  });

  @override
  State<RealtimeIconAnimation> createState() => _RealtimeIconAnimationState();
}

class _RealtimeIconAnimationState extends State<RealtimeIconAnimation> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _pulseAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 1.0, end: 1.2), weight: 1),
      TweenSequenceItem(tween: Tween(begin: 1.2, end: 1.0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _waveAnimation = TweenSequence<double>([
      TweenSequenceItem(tween: Tween(begin: 0.0, end: 1.0), weight: 1),
    ]).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.isActive) {
      return Icon(
        Icons.circle,
        size: widget.size,
        color: Colors.grey,
      );
    }

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            ..._buildWaveCircles(),
            ScaleTransition(
              scale: _pulseAnimation,
              child: Icon(
                Icons.circle,
                size: widget.size * 0.6,
                color: widget.color,
              ),
            ),
          ],
        );
      },
    );
  }

  List<Widget> _buildWaveCircles() {
    final circles = <Widget>[];
    final waveCount = 3;

    for (int i = 0; i < waveCount; i++) {
      final adjustedValue = (_waveAnimation.value - (i * 0.3)).clamp(0.0, 1.0);

      if (adjustedValue > 0) {
        circles.add(
          Opacity(
            opacity: 1.0 - adjustedValue,
            child: Container(
              width: widget.size,
              height: widget.size,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: widget.color.withOpacity(0.3 - (adjustedValue * 0.3)),
              ),
            ),
          ),
        );
      }
    }

    return circles;
  }
}
