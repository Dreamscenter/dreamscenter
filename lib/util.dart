import 'package:flutter/cupertino.dart';

double longestSize(BuildContext buildContext) {
  return MediaQuery.of(buildContext).size.longestSide;
}
