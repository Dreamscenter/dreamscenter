import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

class EnhancedMouseRegionImpl extends StatefulWidget {
  final Function(PointerEnterEvent)? onEnter;
  final Function(PointerExitEvent)? onExit;
  final Function(PointerHoverEvent)? onHover;
  final MouseCursor cursor;
  final bool opaque;
  final HitTestBehavior? hitTestBehavior;
  final Widget? child;

  const EnhancedMouseRegionImpl({
    super.key,
    this.onEnter,
    this.onExit,
    this.onHover,
    this.cursor = MouseCursor.defer,
    this.opaque = true,
    this.hitTestBehavior,
    this.child,
  });

  @override
  // ignore: no_logic_in_create_state
  State<EnhancedMouseRegionImpl> createState() => throw UnimplementedError();
}
