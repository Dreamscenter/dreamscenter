import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:dreamscenter/extensions/stream_extension.dart';
import 'package:dreamscenter/player/player_model.dart';
import 'package:dreamscenter/player/syncplay/syncplay_model.dart';
import 'package:dreamscenter/player/video_playback.dart';
import 'package:flutter/foundation.dart';
import 'package:path/path.dart' as path;

class SyncplayClient {
  final PlayerModel _playerModel;
  final SyncplayModel syncplayModel;
  VideoPlayback? _playback;
  Process? _process;
  File? logFile;

  SyncplayClient(this._playerModel, this.syncplayModel);

  Future<void> start({
    required String serverAddress,
    String? serverPassword,
    required String username,
    required String room,
  }) async {
    logFile = File('log.txt');

    _playerModel.addListener(_onPlayerModelChange);

    const syncplayDirectory = 'syncplay';
    final pythonPath = path.join(syncplayDirectory, 'venv', 'Scripts', 'python.exe');
    _process = await Process.start(
        pythonPath,
        [
          '-m',
          'dreamscenter.main',
          serverAddress.split(":")[0],
          serverAddress.split(":")[1],
          serverPassword ?? "null",
          username,
          room,
        ],
        workingDirectory: syncplayDirectory);
    _process!.stdout.lines().listen(_onSyncplayMessage);

    _process!.stderr.lines().listen((message) {
      if (kDebugMode) {
        print("[ERROR] Syncplay: $message");
      } else {
        logFile!.writeAsStringSync("[ERROR] Syncplay: $message\n", mode: FileMode.append);
      }
    });
  }

  _onSyncplayMessage(String message) {
    if (!message.startsWith('Dreamscenter << ')) {
      if (kDebugMode) {
        print('Syncplay: $message');
      } else {
        logFile!.writeAsStringSync('Syncplay: $message\n', mode: FileMode.append);
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
      case 'setPosition':
        _handleSetPosition(parsedCommand);
        break;
      case 'showUserList':
        _handleShowUserList(parsedCommand);
        break;
      case 'openFile':
        _handleOpenFile(parsedCommand);
        break;
      case 'setSpeed':
        _handleSetSpeed(parsedCommand);
        break;
      case 'setPlaylist':
        _handleSetPlaylist(parsedCommand);
        break;
    }
  }

  _handleAskForStatus(dynamic command) {
    final response = {
      "isPaused": _playback?.isPaused ?? true,
      "position": _playback != null ? (_playback!.position.inMicroseconds / 1000000) : 0,
      "fileName": _playback?.source,
      "duration": _playback?.duration.inSeconds ?? 0,
      "playlist": syncplayModel.urls,
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

  void _handleSetPosition(dynamic command) {
    double value = command['value'];
    _playback?.seekTo(Duration(microseconds: (value * 1000000).toInt()));
    _sendMessageToSyncplay({});
  }

  void _handleShowUserList(dynamic parsedCommand) {
    final users = parsedCommand['users'];
    final typedUsers = <String>[];
    for (final user in users) {
      typedUsers.add(user);
    }
    syncplayModel.users = typedUsers;

    final currentUser = parsedCommand['currentUser'];
    syncplayModel.currentUser = currentUser;
    _sendMessageToSyncplay({});
  }

  void _handleOpenFile(dynamic parsedCommand) {
    final url = parsedCommand['filePath'];
    _playerModel.source = url;
    _sendMessageToSyncplay({});
  }

  void _handleSetSpeed(dynamic parsedCommand) {
    final speed = parsedCommand['speed'];
    _playback?.setSpeed(speed ?? 1);
    _sendMessageToSyncplay({});
  }

  void _handleSetPlaylist(dynamic parsedCommand) {
    final playlist = parsedCommand['playlist'];
    final typedPlaylist = <String>[];
    for (final item in playlist) {
      typedPlaylist.add(item);
    }
    syncplayModel.urls = typedPlaylist;
    _sendMessageToSyncplay({});
  }

  _sendMessageToSyncplay(dynamic response) {
    final message = "Dreamscenter >> ${jsonEncode(response)}\n";
    _process!.stdin.write(message);
  }

  _onPlayerModelChange() {
    if (_playerModel.playback != _playback) {
      _playback = _playerModel.playback;
      Timer(const Duration(seconds: 1), () {
        _playback!.pause();
      });
    }
  }
}
