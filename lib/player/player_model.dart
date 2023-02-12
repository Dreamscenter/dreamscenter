import 'package:dreamscenter/player/widgets/overlay/controls/control_popup.dart';
import 'package:flutter/foundation.dart';

class PlayerModel extends ChangeNotifier {
  ControlPopup? _openedPopup;

  ControlPopup? get openedPopup => _openedPopup;

  set openedPopup(ControlPopup? newValue) {
    _openedPopup = newValue;
    notifyListeners();
  }

  double _volume = 0;

  double get volume => _volume;

  set volume(double newValue) {
    _volume = newValue;
    notifyListeners();
  }
}
