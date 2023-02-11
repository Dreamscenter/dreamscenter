abstract class VideoPlayerController {
  abstract final bool isPaused;
  abstract final Duration? currentPosition;
  abstract final Duration? duration;

  void pause();

  void play();

  void seek(double percentage);

  void setVolume(double volume);
}

class MutableVideoPlayerController extends VideoPlayerController {
  bool _isPaused = false;
  Duration? Function() getCurrentPosition;
  Duration? Function() getDuration;
  Function pauseVideo;
  Function playVideo;
  void Function(Duration) seekVideo;
  void Function(double) setVideoVolume;

  MutableVideoPlayerController({
    required this.getCurrentPosition,
    required this.pauseVideo,
    required this.playVideo,
    required this.seekVideo,
    required this.getDuration,
    required this.setVideoVolume,
  });

  @override
  bool get isPaused => _isPaused;

  @override
  Duration? get duration => getDuration();

  @override
  Duration? get currentPosition => getCurrentPosition();

  @override
  play() {
    _isPaused = false;
    playVideo();
  }

  @override
  pause() {
    _isPaused = true;
    pauseVideo();
  }

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

  @override
  setVolume(double volume) {
    setVideoVolume(volume);
  }
}
