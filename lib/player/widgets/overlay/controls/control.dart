import 'package:dreamscenter/player/widgets/overlay/controls/control_popup.dart';
import 'package:flutter/material.dart';

class Control extends StatelessWidget {
  final Widget icon;
  final Widget popup;

  const Control({super.key, required this.icon, required this.popup});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Listener(
        onPointerUp: (_) {},
        child: MouseRegion(
          cursor: SystemMouseCursors.click,
          child: ControlPopup(
            content: const Text('abcd'),
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
              child: icon,
            ),
          ),
        ),
      ),
    );
  }
}
