import 'package:dreamscenter/player/widgets/overlay/controls/control.dart';
import 'package:flutter/widgets.dart';

class SyncplayControl extends StatelessWidget {
  final GlobalKey popupBoundary;
  final bool showPopup;
  final Function onOpenPopup;

  const SyncplayControl({super.key, required this.popupBoundary, required this.showPopup, required this.onOpenPopup});

  @override
  Widget build(BuildContext context) {
    return Control(
      icon: Image.asset(
        'assets/syncplay.png',
        filterQuality: FilterQuality.medium,
      ),
      popup: const Text("syncplay"),
      popupBoundary: popupBoundary,
      showPopup: showPopup,
      onOpenPopup: onOpenPopup,
    );
  }
}
