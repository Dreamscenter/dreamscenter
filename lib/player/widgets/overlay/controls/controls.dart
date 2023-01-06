import 'package:dreamscenter/player/widgets/overlay/controls/source/source_control.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/syncplay/syncplay_control.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/volume/volume_control.dart';
import 'package:flutter/material.dart';

class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    const buttonSpacing = 21.0;
    return Row(
      children: const [
        VolumeControl(),
        SizedBox(width: buttonSpacing),
        SourceControl(),
        SizedBox(width: buttonSpacing),
        SyncplayControl(),
      ],
    );
  }
}
