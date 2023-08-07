import 'package:flutter/material.dart';

class HeartAnimatingWidget extends StatefulWidget {
  final Widget? child;
  final bool? isAnimating;
  final Duration? duration;
  final VoidCallback? onEnd;
  final bool? alwaysAnimate;

  const HeartAnimatingWidget({
    super.key,
    this.child,
    this.isAnimating,
    this.duration = const Duration(milliseconds: 150),
    this.onEnd,
    this.alwaysAnimate = false,
  });

  @override
  State<HeartAnimatingWidget> createState() => _HeartAnimatingWidgetState();
}

class _HeartAnimatingWidgetState extends State<HeartAnimatingWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> scale;

  @override
  void initState() {
    super.initState();
    final halfDuration = widget.duration!.inMilliseconds ~/ 2;
    _animationController = AnimationController(
      duration: Duration(milliseconds: halfDuration),
      vsync: this,
    );
    scale = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOutCubic,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant HeartAnimatingWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isAnimating != oldWidget.isAnimating) {
      if (widget.isAnimating!) {
        doAnimation();
      }
    }
  }

  Future doAnimation() async {
    if (widget.isAnimating! || widget.alwaysAnimate!) {
      await _animationController.forward();
      await _animationController.reverse();
      await Future.delayed(const Duration(milliseconds: 400));
      if (widget.onEnd != null) {
        widget.onEnd!();
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: scale,
      child: widget.child!,
    );
  }
}
