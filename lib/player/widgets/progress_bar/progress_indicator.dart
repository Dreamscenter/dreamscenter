import 'package:dreamscenter/util.dart';
import 'package:flutter/widgets.dart';

class ProgressIndicator extends StatelessWidget {
  final double progress;
  final Color color;

  const ProgressIndicator({super.key, required this.progress, required this.color});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(longestSize(context)),
          child: Transform.translate(
              offset: Offset(-constraints.maxWidth, 0),
              child: OverflowBox(
                  alignment: Alignment.centerLeft,
                  maxWidth: constraints.maxWidth * 2,
                  child: Container(
                      width: constraints.maxWidth * progress + constraints.maxWidth,
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.circular(longestSize(context)),
                      )))));
    });
  }
}
