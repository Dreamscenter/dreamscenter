import 'package:dreamscenter/device_info.dart';
import 'package:dreamscenter/widgets/enhanced_mouse_region/enhanced_mouse_region.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

class InteractionDetector extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onDoubleTap;
  final void Function(PointerHoverEvent)? onHover;
  final void Function(PointerMoveEvent)? onDrag;
  final void Function(PointerDownEvent)? onTapDown;
  final void Function(PointerUpEvent)? onTapUp;
  final bool showClickCursor;
  final double extraHitboxSize;
  final Widget child;

  const InteractionDetector({
    super.key,
    this.onTap,
    this.onDoubleTap,
    this.onHover,
    this.onDrag,
    this.onTapDown,
    this.onTapUp,
    this.showClickCursor = false,
    this.extraHitboxSize = 0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: FocusManager.instance,
        builder: (_, __) {
          return GestureDetector(
            onTap: onTap,
            onDoubleTap: onDoubleTap,
            child: Listener(
              onPointerHover: onHover,
              onPointerMove: onDrag,
              onPointerUp: onTapUp,
              onPointerDown: onTapDown,
              child: Container(
                color: Colors.transparent,
                padding: isInTouchMode() ? EdgeInsets.all(extraHitboxSize / 2) : null,
                margin: isInTouchMode() ? null : EdgeInsets.all(extraHitboxSize / 2),
                child: showClickCursor ? EnhancedMouseRegion(cursor: SystemMouseCursors.click, child: child) : child,
              ),
            ),
          );
        });
  }
}
