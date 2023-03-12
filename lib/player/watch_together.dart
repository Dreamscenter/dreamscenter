import 'dart:async';
import 'dart:convert';

import 'package:dreamscenter/extensions/num_extension.dart';
import 'package:dreamscenter/player/player_controller.dart';
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
    _channel.stream.listen((message) => _handlePacket(parsePacket(message)));

    _subscriptions.add(_playerController.pauseEvents.listen((_) {
      if (_skipNextPause) {
        _skipNextPause = false;
        return;
      }
      _pauseAt(_playerController.playback!.duration);
    }));

    _subscriptions.add(_playerController.playEvents.listen((_) {
      if (_skipNextPlay) {
        _skipNextPlay = false;
        return;
      }
      _playAt(_playerController.playback!.position);
    }));

    _subscriptions.add(_playerController.sourceStream.listen((source) {
      if (source == null || _skipNextSource) {
        _skipNextSource = false;
        return;
      }

      _setSource(source);
    }));

    _subscriptions.add(_playerController.seekEvents.listen((position) {
      if (_skipNextSeek) {
        _skipNextSeek = false;
        return;
      }

      _setPosition(_playerController.playback!.position);
    }));
  }

  void dispose() {
    _channel.sink.close();
    for (var s in _subscriptions) {
      s.cancel();
    }
  }

  void _handlePacket(WatchTogetherPacket packet) {
    if (kDebugMode) print('Received packet: $packet');

    if (packet is PauseAtPacket) {
      _skipNextPause = true;
      _playerController.pause();
      _playerController.setPosition(packet.position);
    } else if (packet is PlayAtPacket) {
      _skipNextPlay = true;
      _playerController.play();
      _playerController.setPosition(packet.position);
    } else if (packet is SetSource) {
      _skipNextSource = true;
      _playerController.setSource(packet.source);
    } else if (packet is SetPosition) {
      _skipNextSeek = true;
      _playerController.setPosition(packet.position);
    }
  }

  void _pauseAt(Duration position) {
    _channel.sink.add(
      ByteData(10)
        ..setInt16(0, 0)
        ..setFloat64(2, position.inMilliseconds / 1000.0),
    );
  }

  void _playAt(Duration position) {
    _channel.sink.add(
      ByteData(10)
        ..setInt16(0, 1)
        ..setFloat64(2, position.inMilliseconds / 1000.0),
    );
  }

  void _setSource(String source) {
    _channel.sink.add(
      ByteData(2 + source.length)
        ..setInt16(0, 2)
        ..buffer.asUint8List(2).setAll(0, utf8.encode(source)),
    );
  }

  void _setPosition(Duration position) {
    _channel.sink.add(
      ByteData(10)
        ..setInt16(0, 3)
        ..setFloat64(2, position.inMilliseconds / 1000.0),
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

class SetPosition extends WatchTogetherPacket {
  final Duration position;

  SetPosition(this.position);
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

    case 3:
      return SetPosition(view.getFloat64(2).seconds);

    default:
      throw Exception('Unknown packet type: $type');
  }
}
