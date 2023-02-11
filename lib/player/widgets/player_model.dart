import 'package:dreamscenter/player/video_player_controller.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/control_popup.dart';
import 'package:flutter/foundation.dart';

class PlayerModel extends ChangeNotifier {
  double _progress = 0;

  double get progress => _progress;

  set progress(double newValue) {
    _progress = newValue;
    notifyListeners();
  }

  VideoPlayerController? videoPlayer;

  ControlPopup? _openedPopup;

  ControlPopup? get openedPopup => _openedPopup;

  set openedPopup(ControlPopup? newValue) {
    _openedPopup = newValue;
    notifyListeners();
  }
}
