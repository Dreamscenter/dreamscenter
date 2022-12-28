import 'package:dreamscenter/colors.dart';
import 'package:dreamscenter/util.dart';
import 'package:flutter/widgets.dart';

class ProgressBar extends StatelessWidget {
  final double progress;

  const ProgressBar({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Stack(children: [
        _background(context),
        _mediaProgress(context, constraints),
      ]);
    });
  }

  Container _background(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
      color: const Color(0xFF333333),
      borderRadius: BorderRadius.circular(longestSize(context)),
    ));
  }

  ClipRRect _mediaProgress(BuildContext context, BoxConstraints constraints) {
    return ClipRRect(
        borderRadius: BorderRadius.circular(longestSize(context)),
        child: Transform.translate(
            offset: Offset(-constraints.maxWidth, 0),
            child: OverflowBox(
                alignment: Alignment.centerLeft,
                maxWidth: constraints.maxWidth * 2,
                child: Container(
                    width:
                        constraints.maxWidth * progress + constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: Colors.primaryDark,
                      borderRadius: BorderRadius.circular(longestSize(context)),
                    )))));
  }
}
