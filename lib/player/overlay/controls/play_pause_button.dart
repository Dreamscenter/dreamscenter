import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/overlay/controls/control.dart';
import 'package:dreamscenter/player/player_controller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class PlayPauseButton extends StatelessWidget {
  final double extraHitboxSize;
  final bool dropShadow;

  const PlayPauseButton({super.key, required this.extraHitboxSize, required this.dropShadow});

  @override
  Widget build(BuildContext context) {
    final playerController = context.watch<PlayerController>();

    return Control(
      icon: FaIcon(
        playerController.isPaused ? FontAwesomeIcons.play : FontAwesomeIcons.pause,
        color: DefaultColors.primaryDark,
      ),
      onTap: playerController.switchPause,
      extraHitboxSize: extraHitboxSize,
      dropShadow: dropShadow,
    );
  }
}
