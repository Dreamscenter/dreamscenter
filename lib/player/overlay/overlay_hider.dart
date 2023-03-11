import 'dart:async';

import 'package:dreamscenter/device_info.dart';
import 'package:dreamscenter/player/player_view_model.dart';

class OverlayHider {
  final PlayerViewModel _playerViewModel;
  late final StreamSubscription<void> _pauseOrPlaySubscription;
  Timer? _hideOverlayTimer;

  OverlayHider(this._playerViewModel);

  void init() {
    _pauseOrPlaySubscription = _playerViewModel.isPausedStream.listen((_) => updateOverlay());
  }

  void dispose() {
    _pauseOrPlaySubscription.cancel();
    _hideOverlayTimer?.cancel();
  }

  void onPlayerTapDown() {
    if (isInTouchMode()) {
      if (_playerViewModel.showOverlay) {
        _playerViewModel.showOverlay = false;
      } else {
        updateOverlay();
      }
    }
  }

  void onMouseMovement() {
    if (isInDesktopMode()) {
      updateOverlay();
    }
  }

  void updateOverlay() {
    _playerViewModel.showOverlay = true;

    _hideOverlayTimer?.cancel();

    if (_playerViewModel.isPaused || _playerViewModel.openedPopup != null) {
      return;
    }

    _hideOverlayTimer = Timer(Duration(seconds: isInDesktopMode() ? 1 : 5), () {
      _playerViewModel.showOverlay = false;
    });
  }
}
