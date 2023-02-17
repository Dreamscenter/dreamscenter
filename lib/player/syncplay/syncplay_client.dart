import 'dart:convert';
import 'dart:io';

import 'package:dreamscenter/extensions/stream_extension.dart';
import 'package:dreamscenter/player/player_model.dart';
import 'package:dreamscenter/player/video_playback.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

class SyncplayClient {
  final PlayerModel _playerModel;
  VideoPlayback? _playback;
  String? _lastSource;
  Process? _process;

  SyncplayClient(this._playerModel);

  Future<void> start({
    required String serverAddress,
    String? serverPassword,
    required String username,
    required String room,
  }) async {
    _playerModel.addListener(_onPlayerModelChange);

    const syncplayDirectory = 'syncplay';
    final pythonPath = path.join(syncplayDirectory, 'venv', 'Scripts', 'python.exe');
    _process = await Process.start(pythonPath, ['-m', 'dreamscenter.main'], workingDirectory: syncplayDirectory);
    _process!.stdout.lines().listen(_onSyncplayMessage);

    if (kDebugMode) {
      _process!.stderr.lines().listen((message) {
        // ignore: avoid_print
        print("[ERROR] Syncplay: $message");
      });
    }
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

  _onSyncplayMessage(String message) {
    if (!message.startsWith('Dreamscenter << ')) {
      if (kDebugMode) {
        print('Syncplay: $message');
      }

      return;
    }

    final command = message.substring('Dreamscenter << '.length);
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
      "isPaused": _playback?.isPaused ?? true,
      "position": _playback?.position.inMilliseconds ?? 0,
    };

    _sendMessageToSyncplay(response);
  }

  void _handleSetPaused(dynamic command) {
    final value = command['value'];
    if (value) {
      _playback?.pause();
    } else {
      _playback?.play();
    }
    _sendMessageToSyncplay({});
  }

  _sendMessageToSyncplay(dynamic response) {
    final message = "Dreamscenter >> ${jsonEncode(response)}\n";
    _process!.stdin.write(message);
  }

  _onPlayerModelChange() {
    if (_playerModel.playback != _playback && _playerModel.playback != null) {
      _playerModel.playback!.addListener(() {
        if (_playback!.source != _lastSource) {
          // updateFile(_playback!.source, _playback!.duration, _playback!.source);
        }
        _lastSource = _playback!.source;
      });
    }
    _playback = _playerModel.playback;
  }
}
