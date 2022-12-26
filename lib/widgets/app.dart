import 'package:flutter/material.dart';

import 'player/player.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    // Widgets app
    return const MaterialApp(
      title: 'Flutter Demo',
      home: Player(),
    );
  }
}
