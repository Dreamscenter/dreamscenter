import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/overlay/controls/control.dart';
import 'package:dreamscenter/player/player_viewmodel.dart';
import 'package:dreamscenter/player/video_player/video_player_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PlayPauseButton extends StatelessWidget {
  final double extraHitboxSize;
  final bool dropShadow;

  const PlayPauseButton({super.key, required this.extraHitboxSize, required this.dropShadow});

  @override
  Widget build(BuildContext context) {
    final playerViewModel = context.watch<PlayerViewModel>();
    final videoPlayerViewModel = context.read<VideoPlayerViewModel>();

    return Control(
      icon: FaIcon(
        playerViewModel.isPaused ? FontAwesomeIcons.play : FontAwesomeIcons.pause,
        color: DefaultColors.primaryDark,
      ),
      onTap: videoPlayerViewModel.switchPause,
      extraHitboxSize: extraHitboxSize,
      dropShadow: dropShadow,
    );
  }
}

// isPaused && !pausedBySystem -> play
// isPaused && pausedBySystem -> pause
// !isPaused && !pausedBySystem -> pause
