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
        controlsAndProgressBar(
          const Controls(),
          ProgressBar(progress: widget.progress, onSeek: widget.onSeek),
        ),
      ],
    );
  }

  controlsAndProgressBar(Widget controls, Widget progressBar) {
    return LayoutBuilder(builder: (context, constraints) {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          margin: EdgeInsets.only(bottom: constraints.maxHeight * .05 > 20 ? constraints.maxHeight * .05 : 20),
          width: constraints.maxWidth * .05 > 40 ? constraints.maxWidth * .95 : constraints.maxWidth - 40,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 3) + const EdgeInsets.only(bottom: 20),
                child: controls,
              ),
              progressBar,
            ],
          ),
        ),
      );
    });
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
