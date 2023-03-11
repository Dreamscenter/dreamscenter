class VideoPlayerController {
  final Future<void> Function() pause;
  final Future<void> Function() play;
  final Future<void> Function(Duration) setPosition;
  final Future<void> Function(double) setVolume;
  final Future<void> Function(double) setSpeed;

  const VideoPlayerController({
    required this.pause,
    required this.play,
    required this.setPosition,
    required this.setVolume,
    required this.setSpeed,
  });
}
