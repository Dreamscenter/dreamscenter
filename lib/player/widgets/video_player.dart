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
  Media? lastMedia;

  @override
  void initState() {
    super.initState();
    registerListeners();
  }

  @override
  Widget build(BuildContext context) {
    return Video(player: player, showControls: false);
  }

  @override
  void didUpdateWidget(VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.source == oldWidget.source) {
      return;
    }
    if (widget.source == null) {
      if (player.current.media != null) {
        player.stop();
        player = Player(id: Random().nextInt(1000000000));
        registerListeners();
      }
      playback?.dispose();
      widget.onPlaybackChange(null);
      return;
    }

    player.open(Media.network(widget.source));
  }

  registerListeners() {
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

    player.currentStream.listen((event) {
      if (event.media != lastMedia) {
        final playback = VideoPlayback(
          isPaused: false,
          position: player.position.position,
          duration: player.position.duration,
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
          setVideoSpeed: (speed) {
            player.setRate(speed);
          },
        );
        this.playback = playback;
        lastMedia = event.media;
        widget.onPlaybackChange(playback);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    player.dispose();
  }
}
