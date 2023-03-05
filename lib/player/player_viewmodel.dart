import 'dart:async';

import 'package:dreamscenter/player/overlay/controls/control_popup.dart';
import 'package:flutter/widgets.dart';

class PlayerViewModel extends ChangeNotifier {
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

  bool get showMobileControls => FocusManager.instance.highlightMode == FocusHighlightMode.touch;

  bool initialized = false;

  void init() {
    if (initialized) throw StateError('Already initialized');

    Timer.periodic(Duration(seconds: 1), (timer) {
      notifyListeners();
    });

    initialized = true;
  }

  @override
  void dispose() {
    super.dispose();
    FocusManager.instance.removeListener(notifyListeners);
  }
}
