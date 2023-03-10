import 'dart:async';

import 'package:async/async.dart';
import 'package:dreamscenter/player/video_player/video_player_controller.dart';
import 'package:flutter/foundation.dart';

class VideoPlayerViewModel extends ChangeNotifier {
  bool _isPaused = true;
  double _volume = 1.0;
  double _speed = 1.0;
  late VideoPlayerController _controller;
  VideoPlayback? playback;

  void onPaused() {
    _isPaused = true;
    _pauseEventsController.add(null);
    notifyListeners();
  }

  void onPlayed() {
    _isPaused = false;
    _playEventsController.add(null);
    notifyListeners();
  }

  void onPositionChanged(Duration newPosition) {
    playback?.position = newPosition;
    notifyListeners();
  }

  void onDurationChanged(Duration newDuration) {
    playback ??= VideoPlayback();
    playback!.duration = newDuration;
    notifyListeners();
  }

  void onVolumeChanged(double newVolume) {
    _volume = newVolume;
    notifyListeners();
  }

  void onSpeedChanged(double newSpeed) {
    _speed = newSpeed;
    notifyListeners();
  }

  void provideController(VideoPlayerController controller) {
    _controller = controller;
  }

  bool get isPaused => _isPaused;

  double get volume => _volume;

  double get speed => _speed;

  Future<void> pause() => _controller.pause();

  Future<void> play() => _controller.play();

  Future<void> setPosition(Duration newPosition) async {
    playback?.position = newPosition;
    notifyListeners();
    await _controller.setPosition(newPosition);
  }

  Future<void> setVolume(double newVolume) => _controller.setVolume(newVolume);

  Future<void> setSpeed(double newSpeed) => _controller.setSpeed(newSpeed);

  Future<void> switchPause() async {
    if (isPaused) {
      await play();
    } else {
      await pause();
    }
  }

  double get progress {
    if (playback == null) return 0;
    return playback!.position.inMilliseconds / playback!.duration.inMilliseconds;
  }

  Future<void> seek(double progressPercentage) async {
    if (playback == null) return;
    
    final clampedProgress = clampDouble(progressPercentage, 0, 1);
    final newPosition = playback!.duration * clampedProgress;
    await setPosition(newPosition);
  }

  final StreamController<void> _pauseEventsController = StreamController.broadcast();
  final StreamController<void> _playEventsController = StreamController.broadcast();

  Stream<void> get pauseEvents => _pauseEventsController.stream;

  Stream<void> get playEvents => _playEventsController.stream;

  Stream<void> get pauseOrPlayEvents => StreamGroup.merge([pauseEvents, playEvents]);
}

class VideoPlayback {
  Duration position = Duration.zero;
  Duration duration = Duration.zero;
}
