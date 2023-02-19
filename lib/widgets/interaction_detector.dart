import 'package:dreamscenter/widgets/enhanced_mouse_region/enhanced_mouse_region.dart';
import 'package:flutter/widgets.dart';

class InteractionDetector extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onTapDown;
  final void Function()? onDoubleTap;
  final void Function()? onHover;
  final bool showClickCursor;
  final Widget child;

  const InteractionDetector({
    super.key,
    this.onTap,
    this.onTapDown,
    this.onDoubleTap,
    this.onHover,
    this.showClickCursor = false,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final widget = Listener(
      onPointerHover: onHover != null ? (_) => onHover!() : null,
      child: GestureDetector(
        onTap: onTap,
        onTapDown: (_) => onTapDown != null ? onTapDown!() : null,
        onDoubleTap: onDoubleTap,
        child: child,
      ),
    );

    return showClickCursor ? EnhancedMouseRegion(cursor: SystemMouseCursors.click, child: widget) : widget;
  }
}
