import 'dart:ui';

import 'package:window_manager/window_manager.dart';

Future<void> enterFullscreen() async {
  await WindowManager.instance.setFullScreen(true);
}

Future<void> exitFullscreen() async {
  await WindowManager.instance.setFullScreen(false);
  final size = await windowManager.getSize();
  await windowManager.setSize(Size(size.width + 1, size.height + 1));
}

Future<bool> isFullscreen() async {
  return WindowManager.instance.isFullScreen();
}
