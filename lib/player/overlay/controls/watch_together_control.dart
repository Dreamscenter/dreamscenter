import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/overlay/controls/control.dart';
import 'package:dreamscenter/player/watch_together.dart';
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
    final watchTogether = context.read<WatchTogether>();
    return Control(
      icon: FaIcon(FontAwesomeIcons.userGroup, color: color),
      onTap: () {
        watchTogether.connect();
        setState(() => color = Colors.green);
      },
      extraHitboxSize: 24,
    );
  }
}
