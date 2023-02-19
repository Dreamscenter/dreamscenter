import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/widgets.dart';
import 'package:window_manager/window_manager.dart';

void init() async {
  DartVLC.initialize();
  WidgetsFlutterBinding.ensureInitialized();
  await WindowManager.instance.ensureInitialized();
  const windowOptions = WindowOptions(minimumSize: Size(300, 300));
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });
}
