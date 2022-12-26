import 'package:flutter/widgets.dart';

import 'progress_bar.dart';

class PlayerOverlay extends StatelessWidget {
  const PlayerOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Column(
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
            child: const ProgressBar(progress: .5),
          ),
        ],
      );
    });
  }
}
