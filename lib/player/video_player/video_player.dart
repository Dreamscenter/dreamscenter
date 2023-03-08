import 'dart:html';

import 'package:dreamscenter/extensions/num_extension.dart';
import 'package:dreamscenter/player/video_player/video_player_controller.dart';
import 'package:dreamscenter/player/video_player/video_player_viewmodel.dart';
import 'package:flutter/material.dart';

import 'shims/dart_ui.dart' as ui;

class VideoPlayer extends StatefulWidget {
  final String? source;
  final VideoPlayerViewModel viewModel;

  const VideoPlayer({
    super.key,
    required this.source,
    required this.viewModel,
  });

  @override
  State<StatefulWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  late VideoElement video;

  @override
  void initState() {
    super.initState();
    video = VideoElement()
      ..id = 'videoElement'
      ..style.border = 'none'
      ..style.height = '100%'
      ..style.width = '100%'
      ..autoplay = true;

    video.addEventListener('pause', (event) => widget.viewModel.onPaused());
    video.addEventListener('play', (event) => widget.viewModel.onPlayed());
    video.addEventListener('timeupdate', (event) => widget.viewModel.onPositionChanged(video.currentTime.seconds));
    video.addEventListener('loadedmetadata', (event) => widget.viewModel.onDurationChanged(video.duration.seconds));
    video.addEventListener('volumechange', (event) => widget.viewModel.onVolumeChanged(video.volume.toDouble()));
    video.addEventListener('ratechange', (event) => widget.viewModel.onSpeedChanged(video.playbackRate.toDouble()));
    widget.viewModel.provideController(VideoPlayerController(
      pause: () async => ifPlaying(video.pause),
      play: () async => ifPlaying(video.play),
      setPosition: (newPosition) async => ifPlaying(() => video.currentTime = newPosition.inSeconds.toDouble()),
      setVolume: (volume) async => video.volume = volume,
      setSpeed: (speed) async => video.playbackRate = speed,
    ));

    ui.platformViewRegistry.registerViewFactory('videoPlayer', (int viewId) => video);
  }

  void ifPlaying(Function() function) {
    if (widget.source != null) {
      function();
    }
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
    return IgnorePointer(
      child: Container(
        color: Colors.black,
        child: const HtmlElementView(viewType: 'videoPlayer'),
      ),
    );
  }
}
