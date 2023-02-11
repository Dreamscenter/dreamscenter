import 'package:dreamscenter/player/widgets/overlay/controls/control.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/syncplay/syncplay_popup.dart';
import 'package:flutter/widgets.dart';

class SyncplayControl extends StatelessWidget {
  final bool showPopup;
  final void Function() onOpenPopup;

  const SyncplayControl({super.key, required this.showPopup, required this.onOpenPopup});

  @override
  Widget build(BuildContext context) {
    return Control(
      icon: Image.asset(
        'assets/syncplay.png',
        filterQuality: FilterQuality.medium,
      ),
      popup: const SyncplayPopup(),
      showPopup: showPopup,
      onOpenPopup: onOpenPopup,
    );
  }
}
