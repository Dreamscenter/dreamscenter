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

  switchPlayback() {
    if (videoPlayer.isPaused) {
      videoPlayer.play();
    } else {
      videoPlayer.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Listener(
          onPointerUp: (_) => switchPlayback(),
          child: VideoPlayer(
            onProgress: (progress) => setState(() => this.progress = progress),
            setController: (controller) => videoPlayer = controller,
          )),
      PlayerOverlay(progress: progress),
    ]);
  }
}
