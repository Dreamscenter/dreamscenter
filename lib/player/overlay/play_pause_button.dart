import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/video_player/video_player_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({super.key});

  @override
  Widget build(BuildContext context) {
    final videoPlayerViewModel = context.watch<VideoPlayerViewModel>();
    return IgnorePointer(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.25),
              blurRadius: 4,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: FaIcon(
          videoPlayerViewModel.isPaused ? FontAwesomeIcons.play : FontAwesomeIcons.pause,
          color: DefaultColors.primaryDark,
          size: 50,
        ),
      ),
    );
  }
}