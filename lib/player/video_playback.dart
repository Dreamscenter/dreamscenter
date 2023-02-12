import 'package:flutter/cupertino.dart';

class VideoPlayback extends ChangeNotifier {
  bool _isPaused;

  bool get isPaused => _isPaused;

  set isPaused(bool newValue) {
    _isPaused = newValue;
    notifyListeners();
  }

  Duration _position;

  Duration get position => _position;

  set position(Duration newValue) {
    _position = newValue;
    notifyListeners();
  }

  Duration _duration;

  Duration get duration => _duration;

  set duration(Duration newValue) {
    _duration = newValue;
    notifyListeners();
  }

  final void Function() _pauseVideo;
  final void Function() _playVideo;
  final void Function(Duration) _seekVideo;
  final void Function(double) _setVideoVolume;
  final void Function(String) _changeVideoUrl;

  VideoPlayback({
    required isPaused,
    required position,
    required duration,
    required pauseVideo,
    required playVideo,
    required seekVideo,
    required setVideoVolume,
    required changeVideoUrl,
  })  : _isPaused = isPaused,
        _position = position,
        _duration = duration,
        _pauseVideo = pauseVideo,
        _playVideo = playVideo,
        _seekVideo = seekVideo,
        _setVideoVolume = setVideoVolume,
        _changeVideoUrl = changeVideoUrl;

  double get progress {
    final progress = position.inMilliseconds / duration.inMilliseconds;
    return progress.isNaN ? 0 : progress;
  }

  void play() {
    isPaused = false;
    _playVideo();
  }

  void pause() {
    isPaused = true;
    _pauseVideo();
  }

  void seek(double newProgress) {
    final newPosition = duration * newProgress;
    _seekVideo(newPosition);
    position = newPosition;
  }

  void fastForward(Duration duration) {
    _seekVideo(position + duration);
  }

  void rewind(Duration duration) => fastForward(-duration);

  void setVolume(double volume) {
    _setVideoVolume(volume);
  }

  void switchPause() {
    if (isPaused) {
      play();
    } else {
      pause();
    }
  }

  void changeUrl(String url) {
    _changeVideoUrl(url);
  }
}
