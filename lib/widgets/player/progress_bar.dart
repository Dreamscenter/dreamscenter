import 'package:dreamscenter/util.dart';
import 'package:flutter/widgets.dart';

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
          ),
        ),
        Container(
            key: const Key('media progress'),
            width: constraints.maxWidth * progress,
            decoration: BoxDecoration(
              color: const Color(0xFFFF5C00),
              borderRadius: BorderRadius.circular(longestSize(context)),
            )),
      ]);
    });
  }
}
