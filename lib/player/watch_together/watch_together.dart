import 'dart:async';

import 'package:dreamscenter/player/player_controller.dart';
import 'package:dreamscenter/player/watch_together/packets.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WatchTogether {
  bool _isConnected = false;
  late final WebSocketChannel _channel;
  final PlayerController _playerController;
  bool _skipNextPause = false;
  bool _skipNextPlay = false;
  bool _skipNextSource = false;
  bool _skipNextSeek = false;
  final _subscriptions = <StreamSubscription>[];

  WatchTogether(this._playerController);

  void connect() {
    if (_isConnected) return;
    _isConnected = true;
    _channel = WebSocketChannel.connect(
      Uri.parse('wss://api.dreamscenter.app/watch-together/4faf717c-f3dd-43e9-85a7-20bb2d6096ce'),
    );
    _channel.stream.listen((message) {
      _handlePacket(WatchTogetherPacket.fromBytes(ByteData.view(message.buffer)));
    });

    _subscriptions.add(_playerController.pauseEvents.listen((_) {
      if (_skipNextPause) {
        _skipNextPause = false;
        return;
      }
      _sendPacket(PauseAt(position: _playerController.playback!.position));
    }));

    _subscriptions.add(_playerController.playEvents.listen((_) {
      if (_skipNextPlay) {
        _skipNextPlay = false;
        return;
      }
      _sendPacket(Play());
    }));

    _subscriptions.add(_playerController.sourceStream.listen((source) {
      if (source == null || _skipNextSource) {
        _skipNextSource = false;
        return;
      }
      _sendPacket(SetSource(source));
    }));

    _subscriptions.add(_playerController.seekEvents.listen((_) {
      if (_skipNextSeek) {
        _skipNextSeek = false;
        return;
      }

      _sendPacket(SetPosition(_playerController.playback!.position));
    }));
  }

  void dispose() {
    _channel.sink.close();
    for (var s in _subscriptions) {
      s.cancel();
    }
  }

  void _sendPacket(WatchTogetherPacket packet) {
    _channel.sink.add(packet.toBytes());
  }

  void _handlePacket(WatchTogetherPacket packet) async {
    if (packet is PauseAt) {
      _skipNextPause = true;
      await _playerController.pause();
      _skipNextSeek = true;
      _playerController.setPosition(packet.position);
    } else if (packet is Play) {
      _skipNextPlay = true;
      _playerController.play();
    } else if (packet is SetSource) {
      _skipNextSource = true;
      _playerController.setSource(packet.source);
    } else if (packet is SetPosition) {
      _skipNextSeek = true;
      _playerController.setPosition(packet.position);
    }
  }
}
