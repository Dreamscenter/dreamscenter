import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/widgets/player_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VolumePopup extends StatelessWidget {
  const VolumePopup({super.key});

  @override
  Widget build(BuildContext context) {
    final playerModel = Provider.of<PlayerModel>(context);
    return SizedBox(
      width: 200,
      height: 20,
      child: Slider(
        value: playerModel.volume,
        onChanged: (newValue) => playerModel.videoPlayer!.setVolume(newValue),
        activeColor: DefaultColors.primaryDark,
        inactiveColor: DefaultColors.primaryDark.withOpacity(0.5),
      ),
    );
  }
}
