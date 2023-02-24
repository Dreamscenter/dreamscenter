import 'package:flutter/cupertino.dart';

class VideoPlayback extends ChangeNotifier {
  bool _isPaused;

  bool get isPaused => _isPaused;

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

  String _source;

  String get source => _source;

  set source(String newValue) {
    _source = newValue;
    notifyListeners();
  }

  final void Function() _pauseVideo;
  final void Function() _playVideo;
  final void Function(Duration) _seekVideo;
  final void Function(double) _setVideoVolume;
  final void Function(double) _setVideoSpeed;

  VideoPlayback({
    required bool isPaused,
    required Duration position,
    required Duration duration,
    required String source,
    required void Function() pauseVideo,
    required void Function() playVideo,
    required void Function(Duration) seekVideo,
    required void Function(double) setVideoVolume,
    required void Function(double) setVideoSpeed,
  })
      : _isPaused = isPaused,
        _position = position,
        _duration = duration,
        _source = source,
        _pauseVideo = pauseVideo,
        _playVideo = playVideo,
        _seekVideo = seekVideo,
        _setVideoVolume = setVideoVolume,
        _setVideoSpeed = setVideoSpeed;

  double get progress {
    if (duration == Duration.zero) return 0;
    return position.inMilliseconds / duration.inMilliseconds;
  }

  void play() {
    _isPaused = false;
    _playVideo();
    notifyListeners();
  }

  void pause() {
    _isPaused = true;
    _pauseVideo();
    notifyListeners();
  }

  void seek(double newProgress) {
    final newPosition = duration * newProgress;
    _seekVideo(newPosition);
    position = newPosition;
  }

  void seekTo(Duration newPosition) {
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

  void setSpeed(double speed) {
    _setVideoSpeed(speed);
  }
}
