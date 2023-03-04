import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/video_player/video_player_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VolumePopup extends StatelessWidget {
  const VolumePopup({super.key});

  @override
  Widget build(BuildContext context) {
    final videoPlayerViewModel = context.watch<VideoPlayerViewModel>();
    return SizedBox(
      width: 200,
      height: 20,
      child: Slider(
        value: videoPlayerViewModel.volume,
        onChanged: videoPlayerViewModel.setVolume,
        activeColor: DefaultColors.primaryDark,
        inactiveColor: DefaultColors.primaryDark.withOpacity(0.5),
      ),
    );
  }
}
