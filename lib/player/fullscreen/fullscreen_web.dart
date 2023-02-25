import 'dart:html';

import 'package:js/js.dart';

Future<void> enterFullscreen() async {
  document.documentElement!.requestFullscreen();
}

@JS()
@staticInterop
class JSDocument {}

extension JSDocumentExtension on JSDocument {
  external void exitFullscreen();
}

Future<void> exitFullscreen() async {
  final jsDocument = document as JSDocument;
  jsDocument.exitFullscreen();
}

Future<bool> isFullscreen() async {
  return document.fullscreenElement != null;
}
