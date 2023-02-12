import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class SyncplayClient {
  Future<void> start({
    required String serverAddress,
    String? serverPassword,
    required String username,
    required String room,
  }) async {
    const syncplayDirectory = 'syncplay';
    final pythonPath = join(syncplayDirectory, 'venv', 'Scripts', 'python.exe');
    final process = await Process.start(pythonPath, ['-m', 'dreamscenter.main'], workingDirectory: syncplayDirectory);
    process.stdout.listen((event) {
      const inToken = 'Dreamscenter << ';
      final messages = String.fromCharCodes(event);
      for (final message in messages.split('\n')) {
        if (!message.startsWith(inToken)) {
          continue;
        }

        final command = message.substring(inToken.length);
        _handleCommand(command);
      }
    });

    if (kDebugMode) {
      process.stderr.listen((event) {
        // ignore: avoid_print
        print(String.fromCharCodes(event));
      });
    }
  }

  _handleCommand(String command) {
    final parsedCommand = jsonDecode(command);
    final String commandId = parsedCommand['command'];
    switch (commandId) {
      case 'askForStatus':
        print('askForStatus');
        break;
    }
  }
}
