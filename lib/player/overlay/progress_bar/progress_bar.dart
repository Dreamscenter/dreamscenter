import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/overlay/progress_bar/progress_indicator.dart';
import 'package:dreamscenter/player/player_viewmodel.dart';
import 'package:dreamscenter/player/video_player/video_player_viewmodel.dart';
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
  @override
  Widget build(BuildContext context) {
    final playerViewModel = context.read<PlayerViewModel>();
    final videoPlayerViewModel = context.watch<VideoPlayerViewModel>();
    return LayoutBuilder(builder: (context, constraints) {
      return InteractionDetector(
          onTapDown: (event) => handleSeekingStart(event, context, videoPlayerViewModel, playerViewModel),
          onDrag: (event) => handleSeeking(event, context, videoPlayerViewModel),
          onTapUp: (event) => handleSeekStop(videoPlayerViewModel, playerViewModel),
          showClickCursor: true,
          extraHitboxSize: 15,
          child: SizedBox(
            height: 12,
            child: Stack(children: [
              background(context),
              mediaProgress(context, constraints, videoPlayerViewModel.progress),
            ]),
          ));
    });
  }

  Widget mediaProgress(BuildContext context, BoxConstraints constraints, double progress) {
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

  void handleSeekingStart(
    PointerEvent event,
    BuildContext context,
    VideoPlayerViewModel videoPlayerViewModel,
    PlayerViewModel playerViewModel,
  ) {
    wasPaused = videoPlayerViewModel.isPaused;
    if (!videoPlayerViewModel.isPaused) {
      playerViewModel.skipNextPlayPause();
      videoPlayerViewModel.pause();
    }
    handleSeeking(event, context, videoPlayerViewModel);
  }

  void handleSeeking(PointerEvent event, BuildContext context, VideoPlayerViewModel videoPlayerViewModel) {
    final width = context.size!.width;
    final progress = event.localPosition.dx / width;
    videoPlayerViewModel.seek(progress);
  }

  void handleSeekStop(VideoPlayerViewModel videoPlayerViewModel, PlayerViewModel playerViewModel) {
    if (!wasPaused) {
      playerViewModel.skipNextPlayPause();
      videoPlayerViewModel.play();
    }
  }
}
