import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/overlay/controls/control.dart';
import 'package:dreamscenter/player/player_viewmodel.dart';
import 'package:dreamscenter/player/video_player/video_player_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PlayPauseButton extends StatelessWidget {
  final double extraHitboxSize;

  const PlayPauseButton({super.key, required this.extraHitboxSize});

  @override
  Widget build(BuildContext context) {
    final playerViewModel = context.read<PlayerViewModel>();
    final videoPlayerViewModel = context.watch<VideoPlayerViewModel>();
    
    return Control(
      icon: FaIcon(
        videoPlayerViewModel.isPaused && playerViewModel.pausedBySystem ||
                !videoPlayerViewModel.isPaused && !playerViewModel.pausedBySystem
            ? FontAwesomeIcons.pause
            : FontAwesomeIcons.play,
        color: DefaultColors.primaryDark,
      ),
      onTap: videoPlayerViewModel.switchPause,
      extraHitboxSize: extraHitboxSize,
    );
  }
}

// isPaused && !pausedBySystem -> play
// isPaused && pausedBySystem -> pause
// !isPaused && !pausedBySystem -> pause
