import 'dart:convert';

import 'package:dreamscenter/extensions/num_extension.dart';
import 'package:flutter/foundation.dart';

abstract class WatchTogetherPacket {
  ByteData toBytes();

  static fromBytes(ByteData bytes) {
    final type = bytes.getUint8(0);

    switch (type) {
      case PauseAt.id:
        return PauseAt.fromBytes(bytes);

      case PlayAt.id:
        return PlayAt.fromBytes(bytes);

      case SetSource.id:
        return SetSource.fromBytes(bytes);

      case SetPosition.id:
        return SetPosition.fromBytes(bytes);

      default:
        throw Exception('Unknown packet type: $type');
    }
  }
}

class PauseAt extends WatchTogetherPacket {
  static const id = 0;

  final Duration position;

  PauseAt({required this.position});

  PauseAt.fromBytes(ByteData bytes) : position = bytes.getFloat64(1).seconds;

  @override
  ByteData toBytes() {
    return ByteData(10)
      ..setUint8(0, id)
      ..setFloat64(2, position.inMilliseconds / 1000.0);
  }
}

class PlayAt extends WatchTogetherPacket {
  static const id = 1;

  final DateTime timestamp;
  final Duration position;

  PlayAt({required this.timestamp, required this.position});

  PlayAt.fromBytes(ByteData bytes)
      : timestamp = DateTime.fromMillisecondsSinceEpoch(bytes.getUint64(1)),
        position = bytes.getFloat64(9).seconds;

  @override
  ByteData toBytes() {
    return ByteData(10)
      ..setUint8(0, id)
      ..setInt64(2, timestamp.millisecondsSinceEpoch)
      ..setFloat64(10, position.inMilliseconds / 1000.0);
  }
}

class SetSource extends WatchTogetherPacket {
  static const id = 2;

  final String source;

  SetSource(this.source);

  SetSource.fromBytes(ByteData bytes) : source = String.fromCharCodes(bytes.buffer.asUint8List(1));

  @override
  ByteData toBytes() {
    return ByteData(2 + source.length)
      ..setUint8(0, id)
      ..buffer.asUint8List(2).setAll(0, utf8.encode(source));
  }
}

class SetPosition extends WatchTogetherPacket {
  static const id = 3;

  final Duration position;

  SetPosition(this.position);

  SetPosition.fromBytes(ByteData bytes) : position = bytes.getFloat64(1).seconds;

  @override
  ByteData toBytes() {
    return ByteData(10)
      ..setUint8(0, id)
      ..setFloat64(2, position.inMilliseconds / 1000.0);
  }
}
