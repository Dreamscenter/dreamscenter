import 'dart:async';

import 'package:dreamscenter/player/video_player_controller.dart';
import 'package:dreamscenter/player/widgets/player_overlay.dart';
import 'package:dreamscenter/player/widgets/video_player.dart';
import 'package:dreamscenter/widgets/enhanced_mouse_regionlayer.dart';
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
    setState(() {
      showOverlay = true;
    });

    hideOverlayTimer?.cancel();

    if (videoPlayer.isPaused) {
      return;
    }

    hideOverlayTimer = Timer(const Duration(seconds: 1), () {
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

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerHover: (_) => updateOverlay(),
      child: EnhancedMouseRegion(
        cursor: showOverlay ? SystemMouseCursors.basic : SystemMouseCursors.none,
        child: Stack(children: [
          GestureDetector(
            onDoubleTap: switchFullscreen,
            child: Listener(
              onPointerUp: (_) => switchPlayback(),
              child: VideoPlayer(
                onProgressed: (progress) => setState(() => this.progress = progress),
                onPlayed: updateOverlay,
                onPaused: updateOverlay,
                setController: (controller) => videoPlayer = controller,
              ),
            ),
          ),
          AnimatedOpacity(
            opacity: showOverlay ? 1 : 0,
            duration: const Duration(milliseconds: 200),
            child: PlayerOverlay(progress: progress, onSeek: seek),
          ),
        ]),
      ),
    );
  }
}
