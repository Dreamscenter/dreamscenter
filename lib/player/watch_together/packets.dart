import 'dart:convert';

import 'package:dreamscenter/extensions/num_extension.dart';
import 'package:dreamscenter/extensions/string_extension.dart';
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
    return ByteData(9)
      ..setUint8(0, id)
      ..setFloat64(1, position.inMilliseconds / 1000.0);
  }
}

class PlayAt extends WatchTogetherPacket {
  static const id = 1;

  final DateTime timestamp;
  final Duration position;

  PlayAt({required this.timestamp, required this.position});

  PlayAt.fromBytes(ByteData bytes)
      : timestamp = DateTime.fromMillisecondsSinceEpoch(bytes.getUint64S(1)),
        position = bytes.getFloat64(9).seconds;

  @override
  ByteData toBytes() {
    return ByteData(17)
      ..setUint8(0, id)
      ..setUint64S(1, timestamp.millisecondsSinceEpoch)
      ..setFloat64(9, position.inMilliseconds / 1000.0);
  }
}

class SetSource extends WatchTogetherPacket {
  static const id = 2;

  final String source;

  SetSource(this.source);

  SetSource.fromBytes(ByteData bytes) : source = String.fromCharCodes(bytes.buffer.asUint8List(1));

  @override
  ByteData toBytes() {
    return ByteData(1 + source.length)
      ..setUint8(0, id)
      ..buffer.asUint8List(1).setAll(0, utf8.encode(source));
  }
}

class SetPosition extends WatchTogetherPacket {
  static const id = 3;

  final Duration position;

  SetPosition(this.position);

  SetPosition.fromBytes(ByteData bytes) : position = bytes.getFloat64(1).seconds;

  @override
  ByteData toBytes() {
    return ByteData(9)
      ..setUint8(0, id)
      ..setFloat64(1, position.inMilliseconds / 1000.0);
  }
}

extension on ByteData {
  void setUint64S(int byteOffset, int value) {
    final valueAsString = value.toString();
    final low = int.parse(valueAsString.takeLast(8));
    final high = int.parse(valueAsString.take(valueAsString.length - 8));

    setUint32(byteOffset, low);
    setUint32(byteOffset + 4, high);
  }

  int getUint64S(int byteOffset) {
    final low = getUint32(byteOffset);
    final high = getUint32(byteOffset + 4);

    return int.parse('$high$low');
  }
}
