import 'package:dreamscenter/player/widgets/overlay/controls/source/source_control.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/syncplay/syncplay_control.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/volume/volume_control.dart';
import 'package:flutter/material.dart';

class Controls extends StatefulWidget {
  const Controls({super.key});

  @override
  State<Controls> createState() => _ControlsState();
}

class _ControlsState extends State<Controls> {
  final GlobalKey popupBoundary = GlobalKey();
  final GlobalKey volume = GlobalKey();
  final GlobalKey source = GlobalKey();
  final GlobalKey syncplay = GlobalKey();

  @override
  Widget build(BuildContext context) {
    const buttonSpacing = 21.0;
    return SizedBox(
      height: 24,
      child: Row(
        children: [
          VolumeControl(key: volume, popupBoundary: popupBoundary, showPopup: false, onOpenPopup: () {}),
          const SizedBox(width: buttonSpacing),
          SourceControl(key: source, popupBoundary: popupBoundary, showPopup: false, onOpenPopup: () {}),
          const SizedBox(width: buttonSpacing),
          SyncplayControl(key: syncplay, popupBoundary: popupBoundary, showPopup: false, onOpenPopup: () {}),
        ],
      ),
    );
  }
}
