import 'package:dreamscenter/player/widgets/progress_bar.dart';
import 'package:flutter/widgets.dart';

class PlayerOverlay extends StatelessWidget {
  final double progress;

  const PlayerOverlay({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              margin: EdgeInsets.only(
                  bottom: constraints.maxHeight * .05 > 20
                      ? constraints.maxHeight * .05
                      : 20),
              width: constraints.maxWidth * .05 > 40
                  ? constraints.maxWidth * .95
                  : constraints.maxWidth - 40,
              height: 12,
              child: ProgressBar(progress: progress),
            ),
          ],
        ),
      );
    });
  }
}
