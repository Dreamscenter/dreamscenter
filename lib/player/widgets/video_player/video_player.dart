import 'package:dreamscenter/player/video_playback.dart';
import 'package:flutter/widgets.dart';

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
  // ignore: no_logic_in_create_state
  State<StatefulWidget> createState() => throw UnimplementedError();
}
