import 'dart:ui';

import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/overlay/progress_bar/progress_indicator.dart';
import 'package:dreamscenter/player/player_view_model.dart';
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
    final viewModel = context.watch<PlayerViewModel>();
    return InteractionDetector(
        onTapDown: (event) => handleSeekingStart(event, viewModel),
        onDrag: (event) => handleSeeking(event, viewModel),
        onTapUp: (_) => handleSeekStop(viewModel),
        showClickCursor: true,
        extraHitboxSize: extraHitboxSize,
        child: LayoutBuilder(builder: (context, constraints) {
          progressBarContext = context;
          return SizedBox(
            height: 12,
            child: Stack(children: [
              background(context),
              mediaProgress(context, constraints, viewModel),
            ]),
          );
        }));
  }

  Widget mediaProgress(BuildContext context, BoxConstraints constraints, PlayerViewModel viewModel) {
    final progress = viewModel.playback != null
        ? viewModel.playback!.position.inMilliseconds / viewModel.playback!.duration.inMilliseconds
        : 0.0;

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

  void handleSeekingStart(PointerEvent event, PlayerViewModel viewModel) {
    wasPaused = viewModel.isPaused;
    if (!viewModel.isPaused) {
      viewModel.playPauseResolver.skipNextPlayPause();
      viewModel.videoPlayerController.pause();
    }
    handleSeeking(event, viewModel);
  }

  void handleSeeking(PointerEvent event, PlayerViewModel viewModel) {
    final width = progressBarContext.size!.width;
    final progress = (event.localPosition.dx - extraHitboxSize / 2) / width;

    if (viewModel.playback == null) return;

    final clampedProgress = clampDouble(progress, 0, 1);
    final newPosition = viewModel.playback!.duration * clampedProgress;
    viewModel.playback!.position = newPosition;
    viewModel.videoPlayerController.setPosition(newPosition);
  }

  void handleSeekStop(PlayerViewModel viewModel) {
    if (!wasPaused) {
      viewModel.playPauseResolver.skipNextPlayPause();
      viewModel.videoPlayerController.play();
    }
  }
}
