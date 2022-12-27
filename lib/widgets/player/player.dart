import 'package:flutter/widgets.dart';

import 'player_overlay.dart';
import 'video_player.dart';

class Player extends StatefulWidget {
  const Player({super.key});

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  double progress = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      VideoPlayer(
          onProgress: (progress) => setState(() => this.progress = progress)),
      PlayerOverlay(progress: progress),
    ]);
  }
}
