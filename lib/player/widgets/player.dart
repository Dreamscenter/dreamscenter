import 'dart:async';

import 'package:dreamscenter/player/video_player_controller.dart';
import 'package:dreamscenter/player/widgets/overlay/player_overlay.dart';
import 'package:dreamscenter/player/widgets/video_player.dart';
import 'package:dreamscenter/widgets/enhanced_mouse_region.dart';
import 'package:dreamscenter/widgets/interaction_detector.dart';
import 'package:flutter/widgets.dart';
import 'package:window_manager/window_manager.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  double progress = 0;
  late VideoPlayerController videoPlayer;
  Timer? hideOverlayTimer;
  bool showOverlay = false;
  final GlobalKey overlay = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return InteractionDetector(
      onHover: () => updateOverlay(),
      child: EnhancedMouseRegion(
        cursor: showOverlay ? SystemMouseCursors.basic : SystemMouseCursors.none,
        child: Stack(children: [
          InteractionDetector(
            onTap: () => switchPlayback(),
            onDoubleTap: switchFullscreen,
            child: VideoPlayer(
              onProgressed: (progress) => setState(() => this.progress = progress),
              onPlayed: updateOverlay,
              onPaused: updateOverlay,
              setController: (controller) => videoPlayer = controller,
            ),
          ),
          AnimatedOpacity(
            key: overlay,
            opacity: showOverlay ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: PlayerOverlay(progress: progress, onSeek: seek),
          ),
        ]),
      ),
    );
  }

  switchPlayback() {
    if (videoPlayer.isPaused) {
      videoPlayer.play();
    } else {
      videoPlayer.pause();
    }
  }

  seek(double destination) {
    videoPlayer.seek(destination);
  }

  updateOverlay() {
    if (!showOverlay) {
      setState(() {
        showOverlay = true;
      });
    }

    hideOverlayTimer?.cancel();

    if (videoPlayer.isPaused) {
      return;
    }

    hideOverlayTimer = Timer(const Duration(seconds: 1), () {
      if (showOverlay == false) return;
      setState(() {
        showOverlay = false;
      });
    });
  }

  switchFullscreen() async {
    final isFullscreen = await WindowManager.instance.isFullScreen();
    await WindowManager.instance.setFullScreen(!isFullscreen);

    if (isFullscreen) {
      final size = await windowManager.getSize();
      await windowManager.setSize(Size(size.width + 1, size.height + 1));
    }
  }
}
