import 'package:dart_vlc/dart_vlc.dart';
import 'package:dreamscenter/widgets/app.dart';
import 'package:flutter/material.dart';

void main() {
  DartVLC.initialize();
  runApp(const App());
}
