import 'package:dart_vlc/dart_vlc.dart';
import 'package:dreamscenter/widgets/app.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  DartVLC.initialize();

  WidgetsFlutterBinding.ensureInitialized();
  await WindowManager.instance.ensureInitialized();

  const windowOptions = WindowOptions(minimumSize: Size(300, 300));
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
  });

  runApp(const App());
}
