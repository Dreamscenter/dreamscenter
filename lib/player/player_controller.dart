import 'package:dreamscenter/player/player_view_model.dart';
import 'package:flutter/foundation.dart';

class PlayerController extends ChangeNotifier {
  PlayerViewModel viewModel;

  PlayerController(this.viewModel);

  @override
  void addListener(VoidCallback listener) {
    viewModel.addListener(listener);
  }

  @override
  void removeListener(VoidCallback listener) {
    viewModel.removeListener(listener);
  }

  VideoPlayback? get playback {
    final position = viewModel.position;
    final duration = viewModel.duration;
    if (position == null) return null;
    return VideoPlayback(position, duration!);
  }

  bool get isPaused => viewModel.isPaused;

  Future<void> pause() async {
    if (playback == null) return;
    await viewModel.videoPlayerController.pause();
  }

  Future<void> play() async {
    if (playback == null) return;
    await viewModel.videoPlayerController.play();
  }

  Future<void> setPosition(Duration newPosition) async {
    if (playback == null) return;
    viewModel.position = newPosition;
    await viewModel.videoPlayerController.setPosition(newPosition);
  }

  Future<void> setProgress(double newProgress) async {
    if (playback == null) return;

    final clampedProgress = clampDouble(newProgress, 0, 1);
    final newPosition = playback!.duration * clampedProgress;
    await setPosition(newPosition);
  }

  Future<void> setVolume(double newVolume) => viewModel.videoPlayerController.setVolume(newVolume);

  Future<void> setSpeed(double speed) => viewModel.videoPlayerController.setSpeed(speed);

  Future<void> setSource(String? newSource) async => viewModel.source = newSource;

  Future<void> switchPause() async {
    if (isPaused) {
      await play();
    } else {
      await pause();
    }
  }

  Stream<void> get pauseEvents => viewModel.pauseEvents;

  Stream<void> get playEvents => viewModel.playEvents;

  Stream<void> get seekEvents => viewModel.seekEventsController.stream;

  Stream<bool> get isPausedStream => viewModel.isPausedStream;

  Stream<String?> get sourceStream => viewModel.sourceStream;
}

class VideoPlayback {
  final Duration _position;
  final Duration _duration;

  VideoPlayback(this._position, this._duration);

  Duration get position => _position;

  Duration get duration => _duration;

  double get progress => position.inMilliseconds / duration.inMilliseconds;
}
