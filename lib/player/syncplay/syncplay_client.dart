import 'dart:convert';
import 'dart:io';

import 'package:dreamscenter/player/video_playback.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';

class SyncplayClient {
  final VideoPlayback _playback;
  IOSink? _stdin;
  String? _lastSource;

  SyncplayClient(this._playback);

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
          if (message.isNotEmpty) {
            print(message);
          }
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

    _stdin = process.stdin;

    _playback.addListener(() {
      if (_playback.source != _lastSource) {
        updateFile(_playback.source, _playback.duration, _playback.source);
      }
      _lastSource = _playback.source;
    });
  }

  updateFile(String name, Duration duration, String path) {
    final command = {
      "command": "updateFile",
      "name": name,
      "duration": duration.inMilliseconds,
      "path": path,
    };
    _sendMessageToSyncplay(command);
  }

  _handleCommand(String command) {
    final parsedCommand = jsonDecode(command);
    final String commandId = parsedCommand['command'];
    switch (commandId) {
      case 'askForStatus':
        _handleAskForStatus(parsedCommand);
        break;
      case 'setPaused':
        _handleSetPaused(parsedCommand);
        break;
    }
  }

  _handleAskForStatus(dynamic command) {
    final response = {
      "isPaused": _playback.isPaused,
      "position": _playback.position.inMilliseconds,
    };

    _sendMessageToSyncplay(response);
  }

  void _handleSetPaused(dynamic command) {
    final value = command['value'];
    if (value) {
      _playback.pause();
    } else {
      _playback.play();
    }
  }

  _sendMessageToSyncplay(dynamic response) {
    final message = "Dreamscenter >> ${jsonEncode(response)}\n";
    _stdin!.write(message);
  }
}
