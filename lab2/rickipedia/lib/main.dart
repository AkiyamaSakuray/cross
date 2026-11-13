import 'dart:ui';

import 'package:flutter/material.dart';

import 'di/di.dart';
import 'rickipedia.dart';
export 'rickipedia.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupLocator();
  FlutterError.onError = (details) {
    FlutterError.presentError(details);
    talker.handle(details.exception, details.stack);
  };
  PlatformDispatcher.instance.onError = (error, stack) {
    talker.handle(error, stack);
    return true;
  };
  runApp(const RickipediaApp());
}
