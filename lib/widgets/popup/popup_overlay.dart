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
  double margin = 15;

  PopupOverlayLayoutDelegate(this.anchor, this.popupArea);

  @override
  BoxConstraints getConstraintsForChild(BoxConstraints constraints) {
    final anchorTopCenter = anchor.localToGlobal(Offset(anchor.size.width / 2, 0), ancestor: popupArea);
    return BoxConstraints(
      minWidth: 0,
      maxWidth: constraints.maxWidth - margin * 2,
      minHeight: 0,
      maxHeight: anchorTopCenter.dy - margin * 2,
    );
  }

  @override
  Offset getPositionForChild(Size size, Size childSize) {
    final anchorTopCenter = anchor.localToGlobal(Offset(anchor.size.width / 2, 0), ancestor: popupArea);
    final centeredPosition = anchorTopCenter - Offset(childSize.width / 2, 0);
    final upliftedPosition = centeredPosition - Offset(0, childSize.height + 20);
    final clampedPosition = Offset(upliftedPosition.dx.clamp(margin, size.width - childSize.width - margin),
        upliftedPosition.dy.clamp(margin, size.height - childSize.height - margin));

    return clampedPosition;
  }

  @override
  bool shouldRelayout(covariant SingleChildLayoutDelegate oldDelegate) {
    return true;
  }
}
