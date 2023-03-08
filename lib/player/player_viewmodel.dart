import 'package:dreamscenter/player/overlay/controls/control_popup.dart';
import 'package:dreamscenter/player/overlay/overlay_hider.dart';
import 'package:dreamscenter/player/video_player/video_player_viewmodel.dart';
import 'package:flutter/widgets.dart';
import 'package:dreamscenter/device_info.dart';

class PlayerViewModel extends ChangeNotifier {
  final VideoPlayerViewModel _videoPlayerViewModel;

  PlayerViewModel(this._videoPlayerViewModel);

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

  bool get showMobileControls => isInTouchMode();

  bool initialized = false;

  void init() {
    if (initialized) throw StateError('Already initialized');

    FocusManager.instance.addListener(notifyListeners);

    _overlayHider = OverlayHider(this, _videoPlayerViewModel);
    _overlayHider.init();
    _overlayHider.addListener(notifyListeners);

    initialized = true;
  }

  @override
  void dispose() {
    super.dispose();
    FocusManager.instance.removeListener(notifyListeners);
    _overlayHider.dispose();
  }

  late final OverlayHider _overlayHider;

  bool get showOverlay => _overlayHider.showOverlay;

  bool _tapConsumed = false;

  void onPlayerTap() {
    if (_tapConsumed) {
      _tapConsumed = false;
      return;
    }
    
    if (isInDesktopMode()) {
      _videoPlayerViewModel.switchPause();
    }
  }

  void onPlayerTapDown() {
    _overlayHider.onPlayerTapDown();

    if (openedPopup != null) {
      openedPopup = null;
      _tapConsumed =true;
      return;
    }
  }

  void onMouseMovement() => _overlayHider.onMouseMovement();
}
