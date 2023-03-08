import 'dart:async';

import 'package:dreamscenter/device_info.dart';
import 'package:dreamscenter/player/player_viewmodel.dart';
import 'package:dreamscenter/player/video_player/video_player_viewmodel.dart';
import 'package:flutter/foundation.dart';

class OverlayHider extends ChangeNotifier {
  bool _showOverlay = true;

  bool get showOverlay => _showOverlay;

  final PlayerViewModel _playerViewModel;
  final VideoPlayerViewModel _videoPlayerViewModel;
  late final StreamSubscription<void> _pauseOrPlaySubscription;
  Timer? _hideOverlayTimer;

  OverlayHider(this._playerViewModel, this._videoPlayerViewModel);

  void init() {
    _pauseOrPlaySubscription = _videoPlayerViewModel.pauseOrPlayEvents.listen((_) => _updateOverlay());
  }

  @override
  void dispose() {
    super.dispose();
    _pauseOrPlaySubscription.cancel();
    _hideOverlayTimer?.cancel();
  }

  void onPlayerTapDown() {
    if (isInTouchMode()) {
      if (_showOverlay) {
        _setShowOverlay(false);
      } else {
        _updateOverlay();
      }
    }
  }

  void onMouseMovement() {
    if (isInDesktopMode()) {
      _updateOverlay();
    }
  }

  void _updateOverlay() {
    _setShowOverlay(true);

    _hideOverlayTimer?.cancel();

    if (_videoPlayerViewModel.isPaused || _playerViewModel.openedPopup != null) {
      return;
    }

    _hideOverlayTimer = Timer(Duration(seconds: isInDesktopMode() ? 1 : 5), () {
      _setShowOverlay(false);
    });
  }

  void _setShowOverlay(bool newValue) {
    bool shouldNotifyListeners = newValue != _showOverlay;
    _showOverlay = newValue;
    if (shouldNotifyListeners) notifyListeners();
  }
}
