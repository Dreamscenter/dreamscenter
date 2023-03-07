import 'package:dreamscenter/player/overlay/controls/control_popup.dart';
import 'package:dreamscenter/player/overlay/controls/source/source_control.dart';
import 'package:dreamscenter/player/overlay/controls/volume/volume_control.dart';
import 'package:dreamscenter/player/overlay/fullscreen_button.dart';
import 'package:dreamscenter/player/player_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    const buttonSpacing = 21.0;
    final playerViewModel = context.watch<PlayerViewModel>();
    return SizedBox(
      height: 24,
      child: Row(
        children: [
          VolumeControl(
            showPopup: playerViewModel.openedPopup == ControlPopup.volume,
            onOpenPopup: () {
              if (playerViewModel.openedPopup != ControlPopup.volume) {
                playerViewModel.openedPopup = ControlPopup.volume;
              } else {
                playerViewModel.openedPopup = null;
              }
            },
          ),
          const SizedBox(width: buttonSpacing),
          SourceControl(
            showPopup: playerViewModel.openedPopup == ControlPopup.source,
            onOpenPopup: () {
              if (playerViewModel.openedPopup != ControlPopup.source) {
                playerViewModel.openedPopup = ControlPopup.source;
              } else {
                playerViewModel.openedPopup = null;
              }
            },
          ),
          const Spacer(),
          if (playerViewModel.showMobileControls) const FullscreenButton()
        ],
      ),
    );
  }
}
