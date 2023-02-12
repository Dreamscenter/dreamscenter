import 'dart:math';

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
  final player = Player(id: Random().nextInt(1000000000));

  @override
  void initState() {
    super.initState();

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
      changeVideoUrl: (url) {
        player.open(Media.network(url), autoStart: true);
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

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }
}
