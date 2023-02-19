import 'package:dreamscenter/widgets/enhanced_mouse_region/enhanced_mouse_region_def.dart'
    if (dart.library.io) 'package:dreamscenter/widgets/enhanced_mouse_region/enhanced_mouse_region_io.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: non_constant_identifier_names
Widget EnhancedMouseRegion({
  Key? key,
  Function(PointerEnterEvent)? onEnter,
  Function(PointerExitEvent)? onExit,
  Function(PointerHoverEvent)? onHover,
  MouseCursor cursor = MouseCursor.defer,
  bool opaque = true,
  HitTestBehavior? hitTestBehavior,
  Widget? child,
}) =>
    kIsWeb
        ? MouseRegion(
            key: key,
            onEnter: onEnter,
            onExit: onExit,
            onHover: onHover,
            cursor: cursor,
            opaque: opaque,
            child: child,
          )
        : EnhancedMouseRegionImpl(
            key: key,
            onEnter: onEnter,
            onExit: onExit,
            onHover: onHover,
            cursor: cursor,
            opaque: opaque,
            hitTestBehavior: hitTestBehavior,
            child: child);
