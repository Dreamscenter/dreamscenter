import 'package:dreamscenter/widgets/popup/popup_overlay.dart';
import 'package:flutter/widgets.dart';

class Popup extends StatefulWidget {
  final Widget child;
  final Widget popup;
  final bool opened;

  const Popup({super.key, required this.child, required this.popup, required this.opened});

  @override
  State<StatefulWidget> createState() => _PopupState();
}

class _PopupState extends State<Popup> {
  late OverlayEntry overlayEntry;
  late OverlayState overlayState;

  @override
  void initState() {
    super.initState();
    overlayState = Overlay.of(context)!;
    overlayEntry = createOverlayEntry(overlayState);
    if (widget.opened) updatePopup();
  }

  @override
  void didUpdateWidget(Popup oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.opened != widget.opened) updatePopup();
  }

  @override
  void deactivate() {
    super.deactivate();
    if (widget.opened) {
      overlayEntry.remove();
    }
  }

  void updatePopup() {
    if (widget.opened) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        overlayState.insert(overlayEntry);
      });
    } else {
      overlayEntry.remove();
    }
  }

  createOverlayEntry(OverlayState overlayState) {
    final overlayRenderObject = overlayState.context.findRenderObject() as RenderBox;
    return OverlayEntry(builder: (_) {
      final anchor = context.findRenderObject() as RenderBox;
      return PopupOverlay(popup: widget.popup, anchor: anchor, popupArea: overlayRenderObject);
    });
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
