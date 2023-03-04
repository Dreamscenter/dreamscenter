import 'package:dreamscenter/player/overlay/controls/control_popup.dart';
import 'package:flutter/foundation.dart';

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
}
