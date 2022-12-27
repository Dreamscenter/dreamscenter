import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  final Function(double) onProgress;

  const VideoPlayer({super.key, required this.onProgress});

  @override
  State<StatefulWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  final player = Player(id: 69420);

  @override
  void initState() {
    super.initState();
    final network = Media.network(
        'https://vwaw895.cda.pl/SD9wbu9opL-bMQofxtNNUA/1672193102/hdb8c6214ef88fd752792e825fdc377af85f94212d6f3d20746b4bf692f85354bc.mp4');

    player.open(network, autoStart: true);
    player.positionStream.listen((event) {
      if (event.position != null && event.duration != null) {
        final progress =
            event.position!.inMilliseconds / event.duration!.inMilliseconds;

        widget.onProgress(progress);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Video(player: player));
  }
}
