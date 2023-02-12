import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/control.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/source/source_popup.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SourceControl extends StatelessWidget {
  final bool showPopup;
  final void Function() onOpenPopup;

  const SourceControl({super.key, required this.showPopup, required this.onOpenPopup});

  @override
  Widget build(BuildContext context) {
    return Control(
      icon: const FaIcon(FontAwesomeIcons.circlePlay, color: DefaultColors.primaryDark),
      popup: SourcePopup(),
      showPopup: showPopup,
      onOpenPopup: onOpenPopup,
    );
  }
}
