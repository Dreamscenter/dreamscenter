abstract class VideoPlayerController {
  abstract final bool isPaused;

  pause();

  play();
}

class MutableVideoPlayerController extends VideoPlayerController {
  bool Function() getIsPaused;
  Function pauseVideo;
  Function playVideo;

  MutableVideoPlayerController({
    required this.getIsPaused,
    required this.pauseVideo,
    required this.playVideo,
  });

  @override
  bool get isPaused => getIsPaused();

  @override
  pause() => pauseVideo();

  @override
  play() => playVideo();
}
