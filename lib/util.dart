import 'package:flutter/widgets.dart';

double longestSize(BuildContext buildContext) {
  return MediaQuery.of(buildContext).size.longestSide;
}
