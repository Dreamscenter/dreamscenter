import 'package:dreamscenter/player/video_playback.dart';
import 'package:dreamscenter/player/widgets/overlay/controls/control_popup.dart';
import 'package:flutter/foundation.dart';

class PlayerModel extends ChangeNotifier {
  String? _source;

  String? get source => _source;

  set source(String? newValue) {
    _source = newValue;
    notifyListeners();
  }

  ControlPopup? _openedPopup;

  ControlPopup? get openedPopup => _openedPopup;

  set openedPopup(ControlPopup? newValue) {
    _openedPopup = newValue;
    notifyListeners();
  }

  double _volume = 0;

  double get volume => _volume;

  set volume(double newValue) {
    _volume = newValue;
    notifyListeners();
  }

  VideoPlayback? _playback;

  VideoPlayback? get playback => _playback;

  set playback(VideoPlayback? newValue) {
    _playback = newValue;
    notifyListeners();
  }
}
