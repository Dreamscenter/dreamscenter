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
  @override
  Widget build(BuildContext context) {
    return Container(color: Colors.black);
  }
}
