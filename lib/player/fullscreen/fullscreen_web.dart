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

Future<bool> isFullscreen() async {
  return document.fullscreenElement != null || Document.webkitFullscreenElement != null;
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
