import 'package:dreamscenter/extensions/num_extension.dart';
import 'package:dreamscenter/player/video_player/video_player_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WatchTogether {
  bool isConnected = false;
  late final WebSocketChannel channel;
  VideoPlayerViewModel videoPlayerViewModel;

  WatchTogether(this.videoPlayerViewModel);

  void connect() {
    if (isConnected) return;
    isConnected = true;
    const sessionId = '4faf717c-f3dd-43e9-85a7-20bb2d6096ce';
    channel = WebSocketChannel.connect(
      Uri.parse(kDebugMode
          ? 'ws://localhost:8080/watch-together/$sessionId'
          : 'wss://api.dreamscenter.app/watch-together/$sessionId'),
    );
    channel.stream.listen((message) => _handlePacket(parsePacket(message)));
  }

  void _handlePacket(WatchTogetherPacket packet) {
    print('Received packet: $packet');
    if (packet is PauseAtPacket) {
      videoPlayerViewModel.pause();
      videoPlayerViewModel.setPosition(packet.position);
    } else if (packet is PlayAtPacket) {
      videoPlayerViewModel.play();
      videoPlayerViewModel.setPosition(packet.position);
    }
  }

  void pauseAt(Duration position) {
    if (!isConnected) return;

    channel.sink.add(
      ByteData(10)
        ..setInt16(0, 0)
        ..setFloat64(2, position.inMilliseconds / 1000.0),
    );
  }

  void playAt(Duration position) {
    if (!isConnected) return;

    channel.sink.add(
      ByteData(10)
        ..setInt16(0, 1)
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

WatchTogetherPacket parsePacket(Uint8List packet) {
  final view = ByteData.view(packet.buffer);
  final type = view.getInt16(0);

  switch (type) {
    case 0:
      return PauseAtPacket(view.getFloat64(2).seconds);
    case 1:
      return PlayAtPacket(view.getFloat64(2).seconds);
    default:
      throw Exception('Unknown packet type: $type');
  }
}
