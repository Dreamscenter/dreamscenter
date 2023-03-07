import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/fullscreen/fullscreen.dart';
import 'package:dreamscenter/widgets/interaction_detector.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FullscreenButton extends StatelessWidget {
  const FullscreenButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InteractionDetector(
      onTap: switchFullscreen,
      extraHitboxSize: 24,
      child: StreamBuilder(
        stream: fullscreenEvents,
        builder: (_, __) {
          return FaIcon(
            isFullscreen() ? FontAwesomeIcons.compress : FontAwesomeIcons.expand,
            color: DefaultColors.primaryDark,
          );
        },
      ),
    );
  }
}
