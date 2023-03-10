import 'package:dreamscenter/default_colors.dart';
import 'package:dreamscenter/player/overlay/controls/control.dart';
import 'package:dreamscenter/player/player_viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class WatchTogetherControl extends StatelessWidget {
  const WatchTogetherControl({super.key});

  @override
  Widget build(BuildContext context) {
    final playerViewModel = context.read<PlayerViewModel>();
    return Control(
      icon: const FaIcon(FontAwesomeIcons.userGroup, color: DefaultColors.primaryDark),
      onTap: () => playerViewModel.watchTogether.connect(),
      extraHitboxSize: 24,
    );
  }
}
