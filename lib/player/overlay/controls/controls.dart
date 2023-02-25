import 'package:dreamscenter/player/overlay/controls/control_popup.dart';
import 'package:dreamscenter/player/overlay/controls/source/source_control.dart';
import 'package:dreamscenter/player/overlay/controls/volume/volume_control.dart';
import 'package:dreamscenter/player/player_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    const buttonSpacing = 21.0;
    final playerModel = context.watch<PlayerModel>();
    return SizedBox(
      height: 24,
      child: Row(
        children: [
          VolumeControl(
            showPopup: playerModel.openedPopup == ControlPopup.volume,
            onOpenPopup: () {
              if (playerModel.openedPopup != ControlPopup.volume) {
                playerModel.openedPopup = ControlPopup.volume;
              } else {
                playerModel.openedPopup = null;
              }
            },
          ),
          const SizedBox(width: buttonSpacing),
          SourceControl(
            showPopup: playerModel.openedPopup == ControlPopup.source,
            onOpenPopup: () {
              if (playerModel.openedPopup != ControlPopup.source) {
                playerModel.openedPopup = ControlPopup.source;
              } else {
                playerModel.openedPopup = null;
              }
            },
          )
        ],
      ),
    );
  }
}