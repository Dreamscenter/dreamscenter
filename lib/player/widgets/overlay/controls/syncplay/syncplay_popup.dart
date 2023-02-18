import 'package:dreamscenter/player/syncplay/syncplay_model.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/syncplay/syncplay_inside_room.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/syncplay/syncplay_outside_room.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class SyncplayPopup extends StatelessWidget {
  const SyncplayPopup({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<SyncplayModel>(builder: (_, model, __) {
      return model.isInsideRoom ? const SyncplayInsideRoom() : const SyncplayOutsideRoom();
    });
  }
}
