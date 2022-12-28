import 'package:dart_vlc/dart_vlc.dart';
import 'package:dreamscenter/player/video_player_controller.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  final Function(double) onProgress;
  final Function(VideoPlayerController) setController;

  const VideoPlayer({super.key, required this.onProgress, required this.setController});

  @override
  State<StatefulWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  final player = Player(id: 69420);

  @override
  void initState() {
    super.initState();
    final network = Media.network(
        'https://vger025.cda.pl/ld_C9G4B0YKjt9YzdRghZQ/1672270984/hd31168b3f7331b2e5bcf65c862ea2f7685f94212d6f3d20746b4bf692f85354bc.mp4');

    player.open(network, autoStart: true);
    player.positionStream.listen((event) {
      if (event.position != null && event.duration != null) {
        final progress = event.position!.inMilliseconds / event.duration!.inMilliseconds;

        widget.onProgress(progress.isNaN ? 0 : progress);
      }
    });

    final controller = MutableVideoPlayerController(
      getIsPaused: () => !player.playback.isPlaying,
      pauseVideo: () => player.pause(),
      playVideo: () => player.play(),
      seekVideo: (position) => player.seek(position),
      getDuration: () => player.position.duration,
      getCurrentPosition: () => player.position.position,
    );

    widget.setController(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Video(player: player, showControls: false));
  }
}
