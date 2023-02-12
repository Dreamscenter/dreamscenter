import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/widgets/overlay/progress_bar/progress_indicator.dart';
import 'package:dreamscenter/util.dart';
import 'package:flutter/widgets.dart';

class ProgressBar extends StatelessWidget {
  final double progress;
  final void Function(double) onSeek;

  const ProgressBar({super.key, required this.progress, required this.onSeek}) : assert(progress >= 0 && progress <= 1);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
              onTapUp: (details) => handleSeek(details, context),
              child: SizedBox(
                height: 12,
                child: Stack(children: [
                  background(context),
                  mediaProgress(context, constraints),
                ]),
              )));
    });
  }

  background(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(longestSize(context)),
      ),
    );
  }

  mediaProgress(BuildContext context, BoxConstraints constraints) {
    return Stack(children: [
      Container(
        width: constraints.maxWidth * progress,
        height: constraints.maxWidth * progress > constraints.maxHeight
            ? constraints.maxHeight
            : constraints.maxWidth * progress,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(longestSize(context)),
          boxShadow: [
            BoxShadow(
              color: DefaultColors.primaryDark.withOpacity(0.4),
              spreadRadius: 1,
              blurRadius: 10,
            ),
          ],
        ),
      ),
      ProgressIndicator(progress: progress, color: DefaultColors.primaryDark)
    ]);
  }

  handleSeek(TapUpDetails details, BuildContext progressBar) {
    final width = progressBar.size?.width;
    if (width != null) {
      final progress = details.localPosition.dx / width;
      onSeek(progress);
    }
  }
}
