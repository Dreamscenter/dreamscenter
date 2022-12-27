import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';

import 'widgets/app.dart';

void main() {
  DartVLC.initialize();
  runApp(const App());
}
