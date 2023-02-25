import 'dart:html';

Future<void> enterFullscreen() async {
  document.documentElement!.requestFullscreen();
}

Future<void> exitFullscreen() async {
  document.exitFullscreen();
}

Future<bool> isFullscreen() async {
  return document.fullscreenElement != null;
}
