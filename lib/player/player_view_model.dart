import 'dart:async';

import 'package:dreamscenter/player/overlay/controls/control_popup.dart';
import 'package:dreamscenter/player/video_player/video_player_controller.dart';
import 'package:flutter/widgets.dart';

class PlayerViewModel extends ChangeNotifier {
  Duration? _position;
  Duration? _duration;
  bool _isPaused = true;
  double _volume = 1.0;
  double _speed = 1.0;
  String? _source;
  bool _showMobileControls = false;
  ControlPopup? _openedPopup;
  bool _showOverlay = true;

  final StreamController<void> pauseEventsController = StreamController.broadcast();
  final StreamController<void> playEventsController = StreamController.broadcast();
  final StreamController<bool> _isPausedStreamController = StreamController.broadcast();
  final StreamController<String?> _sourceStreamController = StreamController.broadcast();

  late VideoPlayerController videoPlayerController;

  PlayerViewModel();

  Duration? get position => _position;

  set position(Duration? newPosition) {
    final valueChanged = newPosition != _position;
    _position = newPosition;
    if (valueChanged) notifyListeners();
  }

  Duration? get duration => _duration;

  set duration(Duration? newDuration) {
    final valueChanged = newDuration != _duration;
    _duration = newDuration;
    if (valueChanged) notifyListeners();
  }

  bool get isPaused => _isPaused;

  set isPaused(bool newValue) {
    final valueChanged = newValue != _isPaused;
    _isPaused = newValue;
    if (valueChanged) {
      notifyListeners();
      _isPausedStreamController.add(newValue);
    }
  }

  double get volume => _volume;

  set volume(double newVolume) {
    final valueChanged = newVolume != _volume;
    _volume = newVolume;
    if (valueChanged) notifyListeners();
  }

  double get speed => _speed;

  set speed(double newSpeed) {
    final valueChanged = newSpeed != _speed;
    _speed = newSpeed;
    if (valueChanged) notifyListeners();
  }

  String? get source => _source;

  set source(String? newSource) {
    final valueChanged = newSource != _source;
    _source = newSource;
    if (valueChanged) {
      notifyListeners();
      _sourceStreamController.add(newSource);
    }
  }

  bool get showMobileControls => _showMobileControls;

  set showMobileControls(bool newValue) {
    final valueChanged = newValue != _showMobileControls;
    _showMobileControls = newValue;
    if (valueChanged) notifyListeners();
  }

  ControlPopup? get openedPopup => _openedPopup;

  set openedPopup(ControlPopup? newOpenedPopup) {
    final valueChanged = newOpenedPopup != _openedPopup;
    _openedPopup = newOpenedPopup;
    if (valueChanged) notifyListeners();
  }

  bool get showOverlay => _showOverlay;

  set showOverlay(bool newValue) {
    final valueChanged = newValue != _showOverlay;
    _showOverlay = newValue;
    if (valueChanged) notifyListeners();
  }

  Stream<void> get pauseEvents => pauseEventsController.stream;

  Stream<void> get playEvents => playEventsController.stream;

  Stream<bool> get isPausedStream => _isPausedStreamController.stream;

  Stream<String?> get sourceStream => _sourceStreamController.stream;

  @override
  void dispose() {
    super.dispose();
    pauseEventsController.close();
    playEventsController.close();
    _isPausedStreamController.close();
  }
}
