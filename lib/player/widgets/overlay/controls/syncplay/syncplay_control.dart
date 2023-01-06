import 'package:dreamscenter/player/widgets/overlay/controls/control.dart';
import 'package:flutter/widgets.dart';

class SyncplayControl extends StatelessWidget {
  const SyncplayControl({super.key});

  @override
  Widget build(BuildContext context) {
    return Control(
      icon: Image.asset(
        'assets/syncplay.png',
        filterQuality: FilterQuality.medium,
      ),
      popup: const Text('Syncplay'),
    );
  }
}
