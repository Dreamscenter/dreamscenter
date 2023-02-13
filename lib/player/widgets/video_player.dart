import 'dart:math';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:dreamscenter/player/video_playback.dart';
import 'package:flutter/material.dart';

class VideoPlayer extends StatefulWidget {
  final String? source;
  final void Function(double) onVolumeChanged;
  final void Function(VideoPlayback?) onPlaybackChange;

  const VideoPlayer({
    super.key,
    this.source,
    required this.onVolumeChanged,
    required this.onPlaybackChange,
  });

  @override
  State<StatefulWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  var player = Player(id: Random().nextInt(1000000000));
  VideoPlayback? playback;

  @override
  void initState() {
    super.initState();

    player.positionStream.listen((event) {
      if (event.position != null) {
        playback?.position = event.position!;
      }
      if (event.duration != null) {
        playback?.duration = event.duration!;
      }
    });

    player.generalStream.listen((event) {
      widget.onVolumeChanged(event.volume);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Video(player: player, showControls: false);
  }

  @override
  void didUpdateWidget(VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.source == oldWidget.source) {
      print("source not changed");
      return;
    }
    if (widget.source == null) {
      print("source is null");
      if (player.current.media != null) {
        // player.stop();
        // setState(() => player = Player(id: Random().nextInt(1000000000)));
      }
      widget.onPlaybackChange(null);
      return;
    }

    player.open(Media.network(widget.source));
    print("playing ${widget.source}");
    final playback = VideoPlayback(
      isPaused: false,
      position: Duration.zero,
      duration: Duration.zero,
      source: widget.source,
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
    this.playback = playback;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onPlaybackChange(playback);
    });
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }
}
