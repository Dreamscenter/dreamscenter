import 'dart:async';

import 'package:dreamscenter/player/video_player_controller.dart';
import 'package:dreamscenter/player/widgets/player_overlay.dart';
import 'package:dreamscenter/player/widgets/video_player.dart';
import 'package:flutter/widgets.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  double progress = 0;
  late VideoPlayerController videoPlayer;
  bool showOverlay = false;
  Timer? hideOverlayTimer;

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

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerUp: (_) => switchPlayback(),
      onPointerHover: (_) => updateOverlay(),
      child: MouseRegion(
        cursor: showOverlay ? SystemMouseCursors.basic : SystemMouseCursors.none,
        child: Stack(children: [
          VideoPlayer(
            onProgressed: (progress) => setState(() => this.progress = progress),
            onPlayed: updateOverlay,
            onPaused: updateOverlay,
            setController: (controller) => videoPlayer = controller,
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
