import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/control.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VolumeControl extends StatelessWidget {
  final bool showPopup;
  final void Function() onOpenPopup;

  const VolumeControl({super.key, required this.showPopup, required this.onOpenPopup});

  @override
  Widget build(BuildContext context) {
    return Control(
      icon: const FaIcon(FontAwesomeIcons.volumeHigh, color: DefaultColors.primaryDark),
      popup: const Text("volume"),
      showPopup: showPopup,
      onOpenPopup: onOpenPopup,
    );
  }
}
