import 'package:dart_vlc/dart_vlc.dart';
import 'package:dreamscenter/player/video_playback.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  final void Function(double) onVolumeChanged;
  final void Function(VideoPlayback) onPlaybackChange;

  const VideoPlayer({
    super.key,
    required this.onVolumeChanged,
    required this.onPlaybackChange,
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
        'https://vwaw030.cda.pl/mR4Cq40OHPvD7bjosr1oNw/1676234902/hd1cf07eb8f69b5e82d295199fecde4ee7.mp4');

    player.open(network, autoStart: true);

    final playback = VideoPlayback(
      isPaused: false,
      position: Duration.zero,
      duration: Duration.zero,
      playVideo: () {
        player.play();
      },
      pauseVideo: () {
        player.pause();
      },
      seekVideo: (position) {
        player.seek(position);
      },
      setVideoVolume: (volume) {
        player.setVolume(volume);
      },
    );

    player.positionStream.listen((event) {
      if (event.position != null) {
        playback.position = event.position!;
      }
      if (event.duration != null) {
        playback.duration = event.duration!;
      }
    });

    player.generalStream.listen((event) {
      widget.onVolumeChanged(event.volume);
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onPlaybackChange(playback);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Video(player: player, showControls: false);
  }
}
