import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/control.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VolumeControl extends StatelessWidget {
  final GlobalKey popupBoundary;
  final bool showPopup;
  final Function onOpenPopup;

  const VolumeControl({super.key, required this.popupBoundary, required this.showPopup, required this.onOpenPopup});

  @override
  Widget build(BuildContext context) {
    return Control(
      icon: const FaIcon(FontAwesomeIcons.volumeHigh, color: DefaultColors.primaryDark),
      popup: const Text("volume"),
      popupBoundary: popupBoundary,
      showPopup: showPopup,
      onOpenPopup: onOpenPopup,
    );
  }
}
