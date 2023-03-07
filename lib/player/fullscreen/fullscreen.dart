import 'fullscreen_h.dart' if (dart.library.html) 'fullscreen_web.dart' if (dart.library.io) 'fullscreen_io.dart'
    as fullscreen;

Future<void> switchFullscreen() async {
  if (isFullscreen()) {
    await fullscreen.exitFullscreen();
  } else {
    await fullscreen.enterFullscreen();
  }
}

bool isFullscreen() => fullscreen.isFullscreen();

Stream<void> get fullscreenEvents => fullscreen.fullscreenEvents;
