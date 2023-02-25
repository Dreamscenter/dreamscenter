import 'dart:html';

import 'package:dreamscenter/player/video_playback.dart';
import 'package:dreamscenter/player/video_player/shims/dart_ui.dart' as ui;
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
  late VideoElement video;
  VideoPlayback? playback;

  @override
  void initState() {
    super.initState();
    video = VideoElement()
      ..id = 'videoElement'
      ..style.border = 'none'
      ..style.height = '100%'
      ..style.width = '100%'
      ..autoplay = true;

    video.addEventListener('loadedmetadata', (event) {
      playback = VideoPlayback(
        isPaused: video.paused,
        position: Duration(seconds: video.currentTime.toInt()),
        duration: Duration(seconds: video.duration.toInt()),
        source: video.currentSrc,
        pauseVideo: video.pause,
        playVideo: video.play,
        seekVideo: (position) {
          video.currentTime = position.inSeconds;
        },
        setVideoVolume: (newVolume) {
          video.volume = newVolume;
        },
        setVideoSpeed: (videoSpeed) {
          video.playbackRate = videoSpeed;
        },
      );
      widget.onPlaybackChange(playback!);
    });

    video.addEventListener('timeupdate', (event) => playback?.position = Duration(seconds: video.currentTime.toInt()));
    video.addEventListener('volumechange', (event) => widget.onVolumeChanged(video.volume.toDouble()));

    ui.platformViewRegistry.registerViewFactory('videoPlayer', (int viewId) => video);
  }

  @override
  void didUpdateWidget(VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (video.src != widget.source) {
      video.src = widget.source ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const HtmlElementView(viewType: 'videoPlayer'),
    );
  }
}
