import 'package:flutter/widgets.dart';

class InteractionDetector extends StatelessWidget {
  final Widget child;
  final Function()? onTap;
  final Function()? onDoubleTap;
  final Function()? onHover;

  const InteractionDetector({
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.onHover,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: onTap != null ? (_) => onTap!() : null,
      onPointerHover: onHover != null ? (_) => onHover!() : null,
      child: GestureDetector(
        onDoubleTap: onDoubleTap != null ? () => onDoubleTap!() : null,
        child: child,
      ),
    );
  }
}
