import 'package:dreamscenter/widgets/interaction_detector.dart';
import 'package:dreamscenter/widgets/popup/popup.dart';
import 'package:flutter/material.dart';

class Control extends StatelessWidget {
  final Widget icon;
  final Widget popup;
  final bool showPopup;
  final void Function() onOpenPopup;

  const Control({
    super.key,
    required this.icon,
    required this.popup,
    required this.showPopup,
    required this.onOpenPopup,
  });

  @override
  Widget build(BuildContext context) {
    final fitted = FittedBox(
      fit: BoxFit.contain,
      child: icon,
    );

    final withShadow = Container(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.25),
            blurRadius: 4,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: fitted,
    );

    final clickable = InteractionDetector(
      onTap: onOpenPopup,
      showClickCursor: true,
      child: withShadow,
    );

    final withPopup = Popup(
      popup: popup,
      opened: showPopup,
      child: clickable,
    );

    return AspectRatio(
      aspectRatio: 1,
      child: withPopup,
    );
  }
}
