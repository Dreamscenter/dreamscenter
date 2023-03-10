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
  late BuildContext progressBarContext;
  final double extraHitboxSize = 15;
  
  @override
  Widget build(BuildContext context) {
    final playerViewModel = context.read<PlayerViewModel>();
    final videoPlayerViewModel = context.watch<VideoPlayerViewModel>();
    return InteractionDetector(
        onTapDown: (event) => handleSeekingStart(event, videoPlayerViewModel, playerViewModel),
        onDrag: (event) => handleSeeking(event, videoPlayerViewModel),
        onTapUp: (_) => handleSeekStop(videoPlayerViewModel, playerViewModel),
        showClickCursor: true,
        extraHitboxSize: extraHitboxSize,
        child: LayoutBuilder(builder: (context, constraints) {
          progressBarContext = context;
          return SizedBox(
            height: 12,
            child: Stack(children: [
              background(context),
              mediaProgress(context, constraints, videoPlayerViewModel.progress),
            ]),
          );
        }));
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
    VideoPlayerViewModel videoPlayerViewModel,
    PlayerViewModel playerViewModel,
  ) {
    wasPaused = videoPlayerViewModel.isPaused;
    if (!videoPlayerViewModel.isPaused) {
      playerViewModel.skipNextPlayPause();
      videoPlayerViewModel.pause();
    }
    handleSeeking(event, videoPlayerViewModel);
  }

  void handleSeeking(PointerEvent event, VideoPlayerViewModel videoPlayerViewModel) {
    final width = progressBarContext.size!.width;
    final progress = (event.localPosition.dx - extraHitboxSize / 2) / width;
    videoPlayerViewModel.seek(progress);
  }

  void handleSeekStop(VideoPlayerViewModel videoPlayerViewModel, PlayerViewModel playerViewModel) {
    if (!wasPaused) {
      playerViewModel.skipNextPlayPause();
      videoPlayerViewModel.play();
    }
  }
}
