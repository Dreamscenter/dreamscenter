import 'dart:convert';

extension StreamExtension<T> on Stream<List<int>> {
  Stream<String> lines() => transform(utf8.decoder).transform(const LineSplitter());
}
