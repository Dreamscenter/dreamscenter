import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/player_model.dart';
import 'package:dreamscenter/player/video_playback.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VolumePopup extends StatelessWidget {
  const VolumePopup({super.key});

  @override
  Widget build(BuildContext context) {
    final playerModel = context.watch<PlayerModel>();
    final videoPlayback = context.read<VideoPlayback?>();
    return SizedBox(
      width: 200,
      height: 20,
      child: Slider(
        value: playerModel.volume,
        onChanged: videoPlayback?.setVolume,
        activeColor: DefaultColors.primaryDark,
        inactiveColor: DefaultColors.primaryDark.withOpacity(0.5),
      ),
    );
  }
}
