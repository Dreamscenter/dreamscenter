import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/overlay/controls/control.dart';
import 'package:dreamscenter/player/player_view_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PlayPauseButton extends StatelessWidget {
  final double extraHitboxSize;
  final bool dropShadow;

  const PlayPauseButton({super.key, required this.extraHitboxSize, required this.dropShadow});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<PlayerViewModel>();

    return Control(
      icon: FaIcon(
        viewModel.isPaused ? FontAwesomeIcons.play : FontAwesomeIcons.pause,
        color: DefaultColors.primaryDark,
      ),
      onTap: viewModel.switchPause,
      extraHitboxSize: extraHitboxSize,
      dropShadow: dropShadow,
    );
  }
}
