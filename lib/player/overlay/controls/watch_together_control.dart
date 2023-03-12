import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/overlay/controls/control.dart';
import 'package:dreamscenter/player/player_controller.dart';
import 'package:dreamscenter/player/player_view_model.dart';
import 'package:dreamscenter/player/watch_together/watch_together.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class WatchTogetherControl extends StatefulWidget {
  const WatchTogetherControl({super.key});

  @override
  State<WatchTogetherControl> createState() => _WatchTogetherControlState();
}

class _WatchTogetherControlState extends State<WatchTogetherControl> {
  Color color = DefaultColors.primaryDark;

  @override
  Widget build(BuildContext context) {
    final playerController = context.read<PlayerController>();
    final viewModel = context.read<PlayerViewModel>();

    return Control(
      icon: FaIcon(FontAwesomeIcons.userGroup, color: color),
      onTap: () {
        viewModel.watchTogetherSession = WatchTogether(playerController, viewModel);
        viewModel.watchTogetherSession!.connect();
        setState(() => color = Colors.green);
      },
      extraHitboxSize: 24,
    );
  }
}
