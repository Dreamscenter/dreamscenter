abstract class VideoPlayerController {
  abstract final bool isPaused;
  abstract final int? duration;

  pause();

  play();

  seek(double destination);
}

class MutableVideoPlayerController extends VideoPlayerController {
  bool Function() getIsPaused;
  int? Function() getDuration;
  Function pauseVideo;
  Function playVideo;
  Function(double) seekVideo;

  MutableVideoPlayerController({
    required this.getIsPaused,
    required this.pauseVideo,
    required this.playVideo,
    required this.seekVideo,
    required this.getDuration,
  });

  @override
  bool get isPaused => getIsPaused();

  @override
  int? get duration => getDuration();

  @override
  pause() => pauseVideo();

  @override
  play() => playVideo();

  @override
  seek(double destination) => seekVideo(destination);
}
