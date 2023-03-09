import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class Exchanger {
  void connect() {
    final channel = WebSocketChannel.connect(
      Uri.parse(kDebugMode ? 'ws://localhost:8080/exchange' : 'wss://api.dreamscenter.app/exchange'),
    ).stream.listen((message) {
      Uint8List bytes = message;
      final uuid = Uuid.unparse(bytes);
      print(uuid);
    });
  }
  
  void sendMessage() {
    
  }
}
