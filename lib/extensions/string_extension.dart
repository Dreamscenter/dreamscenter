extension StringExtension on String {
  String removePrefix(String prefix) => startsWith(prefix) ? substring(prefix.length) : this;
}
