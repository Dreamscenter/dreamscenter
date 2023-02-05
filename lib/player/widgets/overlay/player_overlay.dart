import 'package:dreamscenter/player/widgets/overlay/controls/controls.dart';
import 'package:dreamscenter/player/widgets/overlay/progress_bar/progress_bar.dart';
import 'package:flutter/material.dart';

class PlayerOverlay extends StatefulWidget {
  final double progress;
  final Function(double) onSeek;

  const PlayerOverlay({super.key, required this.progress, required this.onSeek});

  @override
  State<PlayerOverlay> createState() => _PlayerOverlayState();
}

class _PlayerOverlayState extends State<PlayerOverlay> {
  final GlobalKey controls = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        shadow(),
        Controls(
          key: controls,
          progressBar: ProgressBar(progress: widget.progress, onSeek: widget.onSeek),
        ),
      ],
    );
  }

  shadow() {
    return IgnorePointer(
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
}
