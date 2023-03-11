import 'package:dreamscenter/extensions/num_extension.dart';
import 'package:dreamscenter/player/video_player/video_player_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'dart:convert';

class WatchTogether {
  bool _isConnected = false;
  late final WebSocketChannel _channel;
  final VideoPlayerViewModel _videoPlayerViewModel;

  WatchTogether(this._videoPlayerViewModel);

  void connect() {
    if (_isConnected) return;
    _isConnected = true;
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://api.dreamscenter.app/watch-together/4faf717c-f3dd-43e9-85a7-20bb2d6096ce'),
    );
    _channel.stream.listen((message) => _handlePacket(parsePacket(message)));
  }

  void _handlePacket(WatchTogetherPacket packet) {
    if (kDebugMode) print('Received packet: $packet');
    
    if (packet is PauseAtPacket) {
      _videoPlayerViewModel.pause();
      _videoPlayerViewModel.setPosition(packet.position);
    } else if (packet is PlayAtPacket) {
      _videoPlayerViewModel.play();
      _videoPlayerViewModel.setPosition(packet.position);
    } else if (packet is SetSource) {
      _videoPlayerViewModel.setSource(packet.source);
    }
  }

  void pauseAt(Duration position) {
    if (!_isConnected) return;

    _channel.sink.add(
      ByteData(10)
        ..setInt16(0, 0)
        ..setFloat64(2, position.inMilliseconds / 1000.0),
    );
  }

  void playAt(Duration position) {
    if (!_isConnected) return;

    _channel.sink.add(
      ByteData(10)
        ..setInt16(0, 1)
        ..setFloat64(2, position.inMilliseconds / 1000.0),
    );
  }

  void setSource(String source) {
    if (!_isConnected) return;

    _channel.sink.add(
      ByteData(2 + source.length)
        ..setInt16(0, 2)
        ..buffer.asUint8List(2).setAll(0, utf8.encode(source)),
    );
  }
}

class WatchTogetherPacket {}

class PauseAtPacket extends WatchTogetherPacket {
  final Duration position;

  PauseAtPacket(this.position);
}

class PlayAtPacket extends WatchTogetherPacket {
  final Duration position;

  PlayAtPacket(this.position);
}

class SetSource extends WatchTogetherPacket {
  final String source;

  SetSource(this.source);
}

WatchTogetherPacket parsePacket(Uint8List packet) {
  final view = ByteData.view(packet.buffer);
  final type = view.getInt16(0);

  switch (type) {
    case 0:
      return PauseAtPacket(view.getFloat64(2).seconds);
    case 1:
      return PlayAtPacket(view.getFloat64(2).seconds);
    case 2:
      return SetSource(String.fromCharCodes(packet.sublist(2)));
    default:
      throw Exception('Unknown packet type: $type');
  }
}
