import 'package:dreamscenter/player/overlay/controls/controls.dart';
import 'package:dreamscenter/player/overlay/play_pause_button.dart';
import 'package:dreamscenter/player/overlay/progress_bar/progress_bar.dart';
import 'package:dreamscenter/player/player_viewmodel.dart';
import 'package:dreamscenter/player/video_player/video_player_viewmodel.dart';
import 'package:dreamscenter/widgets/enhanced_overlay.dart';
import 'package:dreamscenter/widgets/fractionally_sized_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PlayerOverlay extends StatefulWidget {
  const PlayerOverlay({super.key});

  @override
  State<PlayerOverlay> createState() => _PlayerOverlayState();
}

class _PlayerOverlayState extends State<PlayerOverlay> {
  @override
  Widget build(BuildContext context) {
    final videoPlayerViewModel = context.watch<VideoPlayerViewModel>();
    final playerViewModel = context.watch<PlayerViewModel>();
    return EnhancedOverlay(
      child: Stack(
        children: [
          shadow,
          controlsAndProgressBar(
            const Controls(),
            ProgressBar(progress: videoPlayerViewModel.progress, onSeek: videoPlayerViewModel.seek),
          ),
          if (playerViewModel.showMobileControls)
            const Center(
              child: PlayPauseButton(),
            )
        ],
      ),
    );
  }

  controlsAndProgressBar(Widget controls, Widget progressBar) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: FractionallySizedContainer(
        marginFactor: const EdgeInsets.only(bottom: .05) + const EdgeInsets.symmetric(horizontal: .025),
        minMargin: const EdgeInsets.only(bottom: 20) + const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              child: controls,
            ),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              child: progressBar,
            ),
          ],
        ),
      ),
    );
  }

  Widget shadow = IgnorePointer(
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.transparent,
            Colors.black.withOpacity(0.92),
            Colors.black,
          ],
          stops: const [0, 0.92, 1],
        ),
      ),
    ),
  );
}
