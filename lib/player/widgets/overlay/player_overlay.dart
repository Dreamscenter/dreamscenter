import 'package:dreamscenter/player/widgets/overlay/controls/controls.dart';
import 'package:dreamscenter/player/widgets/overlay/progress_bar/progress_bar.dart';
import 'package:flutter/material.dart';

class PlayerOverlay extends StatelessWidget {
  final double progress;
  final Function(double) onSeek;

  const PlayerOverlay({super.key, required this.progress, required this.onSeek});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(children: [shadow(), ui(constraints)]);
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

  ui(BoxConstraints constraints) {
    return Center(
        child: Container(
            margin: EdgeInsets.only(bottom: constraints.maxHeight * .05 > 20 ? constraints.maxHeight * .05 : 20),
            width: constraints.maxWidth * .05 > 40 ? constraints.maxWidth * .95 : constraints.maxWidth - 40,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3) + const EdgeInsets.only(bottom: 20),
                  child: const SizedBox(
                    height: 24,
                    child: Controls(),
                  ),
                ),
                SizedBox(
                  height: 12,
                  child: ProgressBar(progress: progress, onSeek: onSeek),
                ),
              ],
            )));
  }
}
