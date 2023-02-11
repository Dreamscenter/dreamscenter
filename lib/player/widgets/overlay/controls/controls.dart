import 'package:dreamscenter/player/widgets/overlay/controls/control_popup.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/source/source_control.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/syncplay/syncplay_control.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/volume/volume_control.dart';
import 'package:dreamscenter/player/widgets/player_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Controls extends StatefulWidget {
  const Controls({super.key});

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  @override
  Widget build(BuildContext context) {
    const buttonSpacing = 21.0;
    final playerModel = Provider.of<PlayerModel>(context);
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
          ),
          const SizedBox(width: buttonSpacing),
          SyncplayControl(
            showPopup: playerModel.openedPopup == ControlPopup.syncplay,
            onOpenPopup: () {
              if (playerModel.openedPopup != ControlPopup.syncplay) {
                playerModel.openedPopup = ControlPopup.syncplay;
              } else {
                playerModel.openedPopup = null;
              }
            },
          ),
        ],
      ),
    );
  }
}
