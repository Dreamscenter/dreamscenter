import 'package:dart_vlc/dart_vlc.dart';
import 'package:dreamscenter/widgets/app.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

void main() async {
  DartVLC.initialize();

  WidgetsFlutterBinding.ensureInitialized();
  await WindowManager.instance.ensureInitialized();

  runApp(const App());
}
