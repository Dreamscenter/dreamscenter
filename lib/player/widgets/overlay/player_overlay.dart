import 'package:dreamscenter/player/widgets/overlay/controls/controls.dart';
import 'package:dreamscenter/player/widgets/overlay/progress_bar/progress_bar.dart';
import 'package:dreamscenter/widgets/enhanced_overlay.dart';
import 'package:dreamscenter/widgets/fractionally_sized_container.dart';
import 'package:flutter/material.dart';

class PlayerOverlay extends StatefulWidget {
  final double progress;
  final void Function(double) onSeek;

  const PlayerOverlay({super.key, required this.progress, required this.onSeek});

  @override
  State<PlayerOverlay> createState() => _PlayerOverlayState();
}

class _PlayerOverlayState extends State<PlayerOverlay> {
  @override
  Widget build(BuildContext context) {
    return EnhancedOverlay(
      child: Stack(
        children: [
          shadow,
          controlsAndProgressBar(
            const Controls(),
            ProgressBar(progress: widget.progress, onSeek: widget.onSeek),
          ),
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
              margin: const EdgeInsets.symmetric(horizontal: 3) + const EdgeInsets.only(bottom: 20),
              child: controls,
            ),
            progressBar,
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
