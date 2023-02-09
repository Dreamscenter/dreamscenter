import 'package:flutter/widgets.dart';

class EnhancedOverlay extends StatefulWidget {
  final Widget child;
  final List<OverlayEntry> initialEntries;
  final Clip clipBehavior;

  const EnhancedOverlay({
    super.key,
    required this.child,
    this.initialEntries = const [],
    this.clipBehavior = Clip.hardEdge,
  });

  @override
  State<EnhancedOverlay> createState() => _EnhancedOverlayState();
}

class _EnhancedOverlayState extends State<EnhancedOverlay> {
  late final entry = OverlayEntry(builder: (context) => widget.child);

  @override
  Widget build(BuildContext context) {
    return Overlay(
      initialEntries: [
        entry,
        ...widget.initialEntries,
      ],
      clipBehavior: widget.clipBehavior,
    );
  }

  @override
  void didUpdateWidget(EnhancedOverlay oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.child != widget.child) {
      entry.markNeedsBuild();
    }
  }
}
