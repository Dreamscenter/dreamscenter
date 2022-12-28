abstract class VideoPlayerController {
  abstract final bool isPaused;
  abstract final Duration? currentPosition;
  abstract final Duration? duration;

  pause();

  play();

  seek(double percentage);
}

class MutableVideoPlayerController extends VideoPlayerController {
  bool Function() getIsPaused;
  Duration? Function() getCurrentPosition;
  Duration? Function() getDuration;
  Function pauseVideo;
  Function playVideo;
  Function(Duration) seekVideo;

  MutableVideoPlayerController({
    required this.getIsPaused,
    required this.getCurrentPosition,
    required this.pauseVideo,
    required this.playVideo,
    required this.seekVideo,
    required this.getDuration,
  });

  @override
  bool get isPaused => getIsPaused();

  @override
  Duration? get duration => getDuration();

  @override
  Duration? get currentPosition => getCurrentPosition();

  @override
  pause() => pauseVideo();

  @override
  play() => playVideo();

  @override
  seek(double percentage) {
    final duration = this.duration;
    if (duration != null) {
      seekVideo(duration * percentage);
    }
  }

  fastForward(Duration duration) {
    final currentPosition = this.currentPosition;
    if (currentPosition != null) {
      seekVideo(currentPosition + duration);
    }
  }

  rewind(Duration duration) => fastForward(-duration);
}
