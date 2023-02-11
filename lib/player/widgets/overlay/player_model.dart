import 'package:dreamscenter/player/video_player_controller.dart';
import 'package:flutter/foundation.dart';

class PlayerModel extends ChangeNotifier {
  double _progress = 0;

  double get progress => _progress;

  set progress(double newValue) {
    _progress = newValue;
    notifyListeners();
  }

  VideoPlayerController? _videoPlayer;

  VideoPlayerController? get videoPlayer => _videoPlayer;

  set videoPlayer(VideoPlayerController? newValue) {
    _videoPlayer = newValue;
    notifyListeners();
  }
}
