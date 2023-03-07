import 'package:dreamscenter/device_info.dart';
import 'package:dreamscenter/widgets/enhanced_mouse_region/enhanced_mouse_region.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class InteractionDetector extends StatelessWidget {
  final void Function()? onTap;
  final void Function()? onTapDown;
  final void Function()? onDoubleTap;
  final void Function()? onHover;
  final bool showClickCursor;
  final double extraHitboxSize;
  final Widget child;

  const InteractionDetector({
    super.key,
    this.onTap,
    this.onTapDown,
    this.onDoubleTap,
    this.onHover,
    this.showClickCursor = false,
    this.extraHitboxSize = 0,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: FocusManager.instance,
        builder: (_, __) {
          return Listener(
            onPointerHover: onHover != null ? (_) => onHover!() : null,
            onPointerDown: (_) => onTapDown != null ? onTapDown!() : null,
            child: GestureDetector(
              onTap: onTap,
              onDoubleTap: onDoubleTap,
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
