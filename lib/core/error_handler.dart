import 'dart:async';
import 'package:flutter/material.dart';
import 'logger.dart';

void setupGlobalErrorHandling() {
  FlutterError.onError = (FlutterErrorDetails details) {
    AppLogger.e(details.exceptionAsString());
    FlutterError.presentError(details);
  };
  runZonedGuarded<Future<void>>(() async {
    // Call your app's main() here
  }, (error, stack) => AppLogger.e(error));
}
