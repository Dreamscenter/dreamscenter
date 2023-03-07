import 'package:flutter/widgets.dart';

bool isInTouchMode() => FocusManager.instance.highlightMode == FocusHighlightMode.touch;

bool isInDesktopMode() => !isInTouchMode();
