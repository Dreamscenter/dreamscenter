import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/control.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Controls extends StatelessWidget {
  const Controls({super.key});

  @override
  Widget build(BuildContext context) {
    const buttonSpacing = 21.0;
    const buttonSize = 24.0;
    return Row(
      children: [
        Control(
          icon: const FaIcon(FontAwesomeIcons.volumeHigh, color: DefaultColors.primaryDark, size: buttonSize),
          onPressed: () {
            print('List');
          },
        ),
        const SizedBox(width: buttonSpacing),
        Control(
          icon: const FaIcon(FontAwesomeIcons.circlePlay, color: DefaultColors.primaryDark, size: buttonSize),
          onPressed: () {
            print('List');
          },
        ),
        const SizedBox(width: buttonSpacing),
        Control(
          icon: Padding(
            padding: const EdgeInsets.only(bottom: 2),
            child: Image.asset(
              'assets/syncplay.png',
              width: buttonSize,
              height: buttonSize,
              filterQuality: FilterQuality.medium,
            ),
          ),
          onPressed: () {
            print('List');
          },
        ),
      ],
    );
  }
}
