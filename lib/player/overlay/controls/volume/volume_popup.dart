import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/player_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VolumePopup extends StatelessWidget {
  const VolumePopup({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PlayerViewModel>();
    return SizedBox(
      width: 200,
      height: 20,
      child: Slider(
        value: viewModel.volume,
        onChanged: (newValue) => viewModel.videoPlayerController.setVolume(newValue),
        activeColor: DefaultColors.primaryDark,
        inactiveColor: DefaultColors.primaryDark.withOpacity(0.5),
      ),
    );
  }
}
