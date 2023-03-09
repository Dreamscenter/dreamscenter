import 'dart:async';

import 'package:dreamscenter/player/video_player/video_player_viewmodel.dart';

class PlayPauseResolver {
  bool _isPaused = true;
  bool _skipNext = false;
  late StreamSubscription<void> playOrPauseSubscription;
  late void Function() _notifyListeners;
  
  bool get isPaused => _isPaused;
  
  void init(VideoPlayerViewModel videoPlayerViewModel, void Function() notifyListeners) {
    _notifyListeners = notifyListeners;
    playOrPauseSubscription = videoPlayerViewModel.pauseOrPlayEvents.listen((_) { 
      if (videoPlayerViewModel.isPaused) {
        _onPause();
      } else {
        _onPlay();
      }
    });
  }
  
  void dispose() {
    playOrPauseSubscription.cancel();
  }
  
  void _onPause() {
    if (_skipNext) {
      _skipNext = false;
      return;
    }
    _isPaused = true;
    _notifyListeners();
  }
  
  void _onPlay() {
    if (_skipNext) {
      _skipNext = false;
      return;
    }
    _isPaused = false;
    _notifyListeners();
  }
  
  void skipNextPlayPause() {
    _skipNext = true;
  }
}
