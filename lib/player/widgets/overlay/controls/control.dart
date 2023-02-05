import 'package:dreamscenter/widgets/popup/popup.dart';
import 'package:flutter/material.dart';

class Control extends StatelessWidget {
  final Widget icon;
  final Widget popup;
  final GlobalKey popupBoundary;
  final bool showPopup;
  final Function onOpenPopup;

  const Control({
    super.key,
    required this.icon,
    required this.popup,
    required this.popupBoundary,
    required this.showPopup,
    required this.onOpenPopup,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Popup(
        popup: const Text("hello popup"),
        opened: showPopup,
        child: Listener(
          onPointerDown: (_) => onOpenPopup(),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 4,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: FittedBox(
                fit: BoxFit.contain,
                child: icon,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
