import 'dart:async';
import 'dart:html';

import 'package:js/js.dart';

Future<void> enterFullscreen() async {
  document.documentElement!.requestFullscreen();
}

Future<void> exitFullscreen() async {
  if (Document.exitFullscreenFunction != null) {
    Document.exitFullscreen();
  } else {
    Document.webkitExitFullscreen();
  }
}

bool isFullscreen() {
  return document.fullscreenElement != null || Document.webkitFullscreenElement != null;
}

Stream<void> fullscreenEvents = fullscreenStream();

Stream<void> fullscreenStream() {
  final controller = StreamController<void>();
  document.addEventListener('fullscreenchange', (_) => controller.add(null));
  return controller.stream;
}

@JS("document")
@staticInterop
class Document {
  external static void exitFullscreen();

  @JS("exitFullscreen")
  external static Object? exitFullscreenFunction;

  external static dynamic webkitFullscreenElement;

  external static void webkitExitFullscreen();
}
