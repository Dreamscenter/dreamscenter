import 'dart:async';
import 'dart:html';

import 'package:dreamscenter/extensions/num_extension.dart';
import 'package:dreamscenter/player/player_view_model.dart';
import 'package:dreamscenter/player/video_player/video_player_controller.dart';
import 'package:flutter/material.dart';

import 'shims/dart_ui.dart' as ui;

class VideoPlayer extends StatefulWidget {
  final PlayerViewModel viewModel;

  const VideoPlayer({
    super.key,
    required this.viewModel,
  });

  @override
  State<StatefulWidget> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  StreamSubscription<String?>? sourceSubscription;

  @override
  void initState() {
    super.initState();
    final viewModel = widget.viewModel;
    
    final video = VideoElement()
      ..id = 'videoElement'
      ..style.border = 'none'
      ..style.height = '100%'
      ..style.width = '100%'
      ..autoplay = true
      ..style.pointerEvents = 'none';

    video.addEventListener('pause', (event) {
      viewModel.isPaused = true;
    });
    video.addEventListener('play', (event) {
      viewModel.isPaused = false;
    });
    video.addEventListener('timeupdate', (_) {
      viewModel.position = video.currentTime.seconds;
    });
    video.addEventListener('loadedmetadata', (_) {
      viewModel.position = video.currentTime.seconds;
      viewModel.duration = video.duration.seconds;
    });
    video.addEventListener('volumechange', (_) {
      viewModel.volume = video.volume.toDouble();
    });
    video.addEventListener('ratechange', (_) {
      viewModel.speed = video.playbackRate.toDouble();
    });
    video.addEventListener('seek', (_) {
      viewModel.seekEventsController.add(null);
    });

    widget.viewModel.videoPlayerController = VideoPlayerController(
      pause: () async => video.pause(),
      play: () async => video.play(),
      setPosition: (newPosition) async => video.currentTime = newPosition.inSeconds.toDouble(),
      setVolume: (newVolume) async => video.volume = newVolume,
      setSpeed: (newSpeed) async => video.playbackRate = newSpeed,
    );

    sourceSubscription = viewModel.sourceStream.listen((newSource) {
      video.src = newSource ?? '';
    });

    ui.platformViewRegistry.registerViewFactory('videoPlayer', (int viewId) => video);
  }
  
  @override
  void dispose() {
    super.dispose();
    sourceSubscription?.cancel();
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
