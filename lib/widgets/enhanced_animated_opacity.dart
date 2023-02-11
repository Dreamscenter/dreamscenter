import 'package:flutter/widgets.dart';

class EnhancedAnimatedOpacity extends StatefulWidget {
  final double opacity;
  final Curve curve;
  final Duration duration;
  final void Function()? onEnd;
  final bool alwaysIncludeSemantics;
  final Widget? child;

  const EnhancedAnimatedOpacity({
    super.key,
    required this.opacity,
    this.curve = Curves.linear,
    required this.duration,
    this.onEnd,
    this.alwaysIncludeSemantics = false,
    this.child,
  });

  @override
  State<EnhancedAnimatedOpacity> createState() => _EnhancedAnimatedOpacityState();
}

class _EnhancedAnimatedOpacityState extends State<EnhancedAnimatedOpacity> {
  bool ignorePointer = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: widget.opacity,
      curve: widget.curve,
      duration: widget.duration,
      onEnd: () {
        setState(() => ignorePointer = widget.opacity == 0);
        widget.onEnd?.call();
      },
      alwaysIncludeSemantics: widget.alwaysIncludeSemantics,
      child: IgnorePointer(
        ignoring: ignorePointer,
        child: widget.child,
      ),
    );
  }
}
