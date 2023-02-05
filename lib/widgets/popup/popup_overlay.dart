import 'package:dreamscenter/widgets/popup/popup_box.dart';
import 'package:dreamscenter/widgets/popup/popup_custom_single_child_layout.dart';
import 'package:flutter/widgets.dart';

class PopupOverlay extends StatelessWidget {
  final Widget popup;
  final RenderBox anchor;
  final RenderBox popupArea;

  const PopupOverlay({super.key, required this.popup, required this.anchor, required this.popupArea});

  @override
  Widget build(BuildContext context) {
    return PopupCustomSingleChildLayout(
        delegate: PopupOverlayLayoutDelegate(anchor, popupArea), child: PopupBox(child: popup));
  }
}

class PopupOverlayLayoutDelegate extends SingleChildLayoutDelegate {
  RenderBox anchor;
  RenderBox popupArea;

  PopupOverlayLayoutDelegate(this.anchor, this.popupArea);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    return BoxConstraints(
      minWidth: 0,
      maxWidth: constraints.maxWidth,
      minHeight: 0,
      maxHeight: constraints.maxHeight,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final anchorPosition = anchor.localToGlobal(Offset.zero, ancestor: popupArea);
    final centeredPosition = anchorPosition - Offset(childSize.width / 2, childSize.height / 2);
    final clampedPosition = Offset(centeredPosition.dx.clamp(0, size.width - childSize.width),
        centeredPosition.dy.clamp(0, size.height - childSize.height));
    final upliftedPosition = clampedPosition - const Offset(0, 50);

    return upliftedPosition;
  }

  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) {
    return true;
  }
}
