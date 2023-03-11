import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/overlay/controls/control.dart';
import 'package:dreamscenter/player/player_viewmodel.dart';
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
    final playerViewModel = context.read<PlayerViewModel>();
    return Control(
      icon: FaIcon(FontAwesomeIcons.userGroup, color: color),
      onTap: () {
        playerViewModel.watchTogether.connect();
        setState(() {
          color = Colors.red;
        });
      },
      extraHitboxSize: 24,
    );
  }
}
