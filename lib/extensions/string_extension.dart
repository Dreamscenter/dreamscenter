extension StringExtension on String {
  String removePrefix(String prefix) => startsWith(prefix) ? substring(prefix.length) : this;

  String takeLast(int count) => substring(length - count);

  String take(int count) => substring(0, count);
}
