import 'package:dart_vlc/dart_vlc.dart';
import 'package:dreamscenter/player/video_player_controller.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  final Function(double) onProgressed;
  final Function() onPlayed;
  final Function onPaused;
  final Function(VideoPlayerController) setController;

  const VideoPlayer({
    super.key,
    required this.onProgressed,
    required this.onPlayed,
    required this.onPaused,
    required this.setController,
  });

  @override
  State<StatefulWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  final player = Player(id: 69420);

  @override
  void initState() {
    super.initState();
    final network = Media.network(
        'https://vwaw575.cda.pl/l7QKsqTpjM6XqBwguX3T9Q/1675635307/hdebb785afd7523dc492f795659ef5c41d.mp4');

    player.open(network, autoStart: true);
    player.positionStream.listen((event) {
      if (event.position != null && event.duration != null) {
        final progress = event.position!.inMilliseconds / event.duration!.inMilliseconds;

        widget.onProgressed(progress.isNaN ? 0 : progress);
      }
    });

    getCurrentPosition() => player.position.position;
    getDuration() => player.position.duration;

    final controller = MutableVideoPlayerController(
      playVideo: () {
        player.play();
        widget.onPlayed();
      },
      pauseVideo: () {
        player.pause();
        widget.onPaused();
      },
      seekVideo: (position) {
        player.seek(position);
        final duration = getDuration();
        if (duration != null) {
          widget.onProgressed(position.inMilliseconds / duration.inMilliseconds);
        }
      },
      getCurrentPosition: getCurrentPosition,
      getDuration: getDuration,
    );

    widget.setController(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Video(player: player, showControls: false);
  }
}
