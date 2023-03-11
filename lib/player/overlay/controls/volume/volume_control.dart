import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/overlay/controls/control.dart';
import 'package:dreamscenter/player/overlay/controls/control_popup.dart';
import 'package:dreamscenter/player/overlay/controls/volume/volume_popup.dart';
import 'package:dreamscenter/player/player_view_model.dart';
import 'package:dreamscenter/widgets/popup/popup.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class VolumeControl extends StatelessWidget {
  const VolumeControl({super.key});

  @override
  Widget build(BuildContext context) {
    final playerViewModel = context.watch<PlayerViewModel>();
    return Popup(
      popup: const VolumePopup(),
      opened: playerViewModel.openedPopup == ControlPopup.volume,
      child: Control(
        icon: const FaIcon(FontAwesomeIcons.volumeHigh, color: DefaultColors.primaryDark),
        onTap: () {
          if (playerViewModel.openedPopup != ControlPopup.volume) {
            playerViewModel.openedPopup = ControlPopup.volume;
          } else {
            playerViewModel.openedPopup = null;
          }
        },
        extraHitboxSize: 24,
      ),
    );
  }
}
