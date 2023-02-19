import 'dart:async';
import 'dart:ffi';
import 'dart:io';

import 'package:ffi/ffi.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:win32/win32.dart';

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
  State<EnhancedMouseRegionImpl> createState() => _EnhancedMouseRegionImplState();
}

class _EnhancedMouseRegionImplState extends State<EnhancedMouseRegionImpl> {
  MouseCursor? lastCursor;

  @override
  Widget build(BuildContext context) {
    if (lastCursor != widget.cursor && Platform.isWindows) {
      Timer(const Duration(milliseconds: 100), () {
        Pointer<POINT> point = malloc();
        GetCursorPos(point);
        SetCursorPos(point.ref.x, point.ref.y);
        free(point);
      });
    }
    lastCursor = widget.cursor;

    return MouseRegion(
      onEnter: widget.onEnter,
      onExit: widget.onExit,
      onHover: widget.onHover,
      cursor: widget.cursor,
      opaque: widget.opaque,
      hitTestBehavior: widget.hitTestBehavior,
      child: widget.child,
    );
  }
}
