import 'package:flutter/material.dart';

/// Simple fade + scale entrance animation (no extra packages).
///
/// Why this widget exists:
/// - Makes product cards / empty states feel a bit more polished
/// - Beginners can wrap any child without learning AnimationController
class FadeScaleIn extends StatefulWidget {
  const FadeScaleIn({
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 350),
    super.key,
  });

  final Widget child;
  final Duration delay;
  final Duration duration;

  @override
  State<FadeScaleIn> createState() => _FadeScaleInState();
}

class _FadeScaleInState extends State<FadeScaleIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    );
    _fade = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _scale = Tween<double>(begin: 0.96, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );

    Future<void>.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _fade,
      child: ScaleTransition(
        scale: _scale,
        child: widget.child,
      ),
    );
  }
}
