extension NumExtension on num {
  Duration get seconds => Duration(milliseconds: (this * 1000).round());
}
