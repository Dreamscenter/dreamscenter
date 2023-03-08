import 'package:dreamscenter/device_info.dart';
import 'package:dreamscenter/player/overlay/controls/source/source_control.dart';
import 'package:dreamscenter/player/overlay/controls/volume/volume_control.dart';
import 'package:dreamscenter/player/overlay/controls/fullscreen_button.dart';
import 'package:dreamscenter/player/overlay/controls/play_pause_button.dart';
import 'package:flutter/material.dart';

class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    const buttonSpacing = 0.0;
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          if (isInDesktopMode()) ...[
            const PlayPauseButton(extraHitboxSize: 24),
            const SizedBox(width: buttonSpacing),
            const VolumeControl(),
            const SizedBox(width: buttonSpacing)
          ],
          const SourceControl(),
          const Spacer(),
          const FullscreenButton()
        ],
      ),
    );
  }
}
