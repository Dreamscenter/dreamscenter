import 'package:dreamscenter/player/widgets/player.dart';
import 'package:flutter/material.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Widgets app
    return const MaterialApp(
      title: 'Dreamscenter',
      home: Scaffold(
        body: Player(),
      ),
    );
  }
}
