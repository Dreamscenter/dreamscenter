import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/overlay/overlay_hider.dart';
import 'package:dreamscenter/player/overlay/progress_bar/progress_indicator.dart';
import 'package:dreamscenter/player/player_controller.dart';
import 'package:dreamscenter/util.dart';
import 'package:dreamscenter/widgets/interaction_detector.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class ProgressBar extends StatefulWidget {
  const ProgressBar({super.key});

  @override
  State<ProgressBar> createState() => _ProgressBarState();
}

class _ProgressBarState extends State<ProgressBar> {
  late BuildContext progressBarContext;
  final double extraHitboxSize = 15;

  @override
  Widget build(BuildContext context) {
    final playerController = context.watch<PlayerController>();
    final overlayHider = context.read<OverlayHider>();

    return InteractionDetector(
        onTapDown: (event) => handleSeekingStart(event, playerController, overlayHider),
        onDrag: (event) => handleSeeking(event, playerController, overlayHider),
        onTapUp: (_) => handleSeekStop(playerController),
        showClickCursor: true,
        extraHitboxSize: extraHitboxSize,
        child: LayoutBuilder(builder: (context, constraints) {
          progressBarContext = context;
          return SizedBox(
            height: 12,
            child: Stack(children: [
              background(context),
              mediaProgress(context, constraints, playerController),
            ]),
          );
        }));
  }

  Widget mediaProgress(BuildContext context, BoxConstraints constraints, PlayerController playerController) {
    final progress = playerController.playback?.progress ?? 0;

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

  Widget background(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(longestSize(context)),
      ),
    );
  }

  bool wasPaused = false;

  void handleSeekingStart(PointerEvent event, PlayerController playerController, OverlayHider overlayHider) {
    wasPaused = playerController.isPaused;
    if (!playerController.isPaused) {
      playerController.pause();
    }
    handleSeeking(event, playerController, overlayHider);
  }

  void handleSeeking(PointerEvent event, PlayerController playerController, OverlayHider overlayHider) {
    final width = progressBarContext.size!.width;
    final progress = (event.localPosition.dx - extraHitboxSize / 2) / width;
    playerController.setProgress(progress);
    overlayHider.updateOverlay();
  }

  void handleSeekStop(PlayerController playerController) {
    if (!wasPaused) {
      playerController.play();
    }
  }
}
