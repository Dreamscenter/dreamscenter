import 'fullscreen_h.dart' if (dart.library.html) 'fullscreen_web.dart' if (dart.library.io) 'fullscreen_io.dart';

Future<void> switchFullscreen() async {
  if (await isFullscreen()) {
    await exitFullscreen();
  } else {
    await enterFullscreen();
  }
}
