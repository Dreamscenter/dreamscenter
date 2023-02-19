import 'package:dreamscenter/init/init_def.dart' if (dart.library.io) 'package:dreamscenter/init/init_io.dart';
import 'package:dreamscenter/widgets/app.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

void main() async {
  if (!kIsWeb) {
    init();
  }

  runApp(const App());
}
