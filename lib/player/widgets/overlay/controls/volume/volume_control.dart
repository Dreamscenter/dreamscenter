import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/control.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class VolumeControl extends StatelessWidget {
  const VolumeControl({super.key});

  @override
  Widget build(BuildContext context) {
    return const Control(
      icon: FaIcon(FontAwesomeIcons.volumeHigh, color: DefaultColors.primaryDark),
      popup: Text('Volume'),
    );
  }
}
