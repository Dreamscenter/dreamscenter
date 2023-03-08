import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/overlay/controls/control.dart';
import 'package:dreamscenter/player/overlay/controls/control_popup.dart';
import 'package:dreamscenter/player/overlay/controls/source/source_popup.dart';
import 'package:dreamscenter/player/player_viewmodel.dart';
import 'package:dreamscenter/widgets/popup/popup.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class SourceControl extends StatelessWidget {
  const SourceControl({super.key});

  @override
  Widget build(BuildContext context) {
    final playerViewModel = context.watch<PlayerViewModel>();
    return Popup(
      popup: const SourcePopup(),
      opened: playerViewModel.openedPopup == ControlPopup.source,
      child: Control(
        icon: const FaIcon(FontAwesomeIcons.circlePlay, color: DefaultColors.primaryDark),
        onTap: () {
          if (playerViewModel.openedPopup != ControlPopup.source) {
            playerViewModel.openedPopup = ControlPopup.source;
          } else {
            playerViewModel.openedPopup = null;
          }
        },
        extraHitboxSize: 24,
      ),
    );
  }
}
