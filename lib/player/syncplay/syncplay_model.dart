import 'package:dreamscenter/player/syncplay/syncplay_client.dart';
import 'package:flutter/foundation.dart';

class SyncplayModel extends ChangeNotifier {
  bool _isInsideRoom = false;

  bool get isInsideRoom => _isInsideRoom;

  set isInsideRoom(bool newValue) {
    _isInsideRoom = newValue;
    notifyListeners();
  }

  List<String> _users = [];

  List<String> get users => _users;

  set users(List<String> newValue) {
    _users = newValue;
    notifyListeners();
  }

  List<String> _urls = [];

  List<String> get urls => _urls;

  set urls(List<String> newValue) {
    _urls = newValue;
    notifyListeners();
  }

  String? _currentUser;

  String? get currentUser => _currentUser;

  set currentUser(String? newValue) {
    _currentUser = newValue;
    notifyListeners();
  }

  SyncplayClient? client;
}
