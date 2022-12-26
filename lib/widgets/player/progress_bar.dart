import 'package:dreamscenter/util.dart';
import 'package:flutter/widgets.dart';

import '../../colors.dart';

class ProgressBar extends StatelessWidget {
  final double progress;

  const ProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(children: [
        Container(
            key: const Key('background'),
            decoration: BoxDecoration(
              color: const Color(0xFF333333),
              borderRadius: BorderRadius.circular(longestSize(context)),
            )),
        ClipRRect(
            borderRadius: BorderRadius.circular(longestSize(context)),
            child: Transform.translate(
                offset: Offset(-constraints.maxWidth, 0),
                child: OverflowBox(
                    alignment: Alignment.centerLeft,
                    maxWidth: constraints.maxWidth * 2,
                    child: Container(
                        key: const Key('media progress'),
                        height: constraints.maxHeight,
                        width: constraints.maxWidth * progress +
                            constraints.maxWidth,
                        decoration: BoxDecoration(
                          color: Colors.primaryDark,
                          borderRadius:
                              BorderRadius.circular(longestSize(context)),
                        ))))),
      ]);
    });
  }
}
