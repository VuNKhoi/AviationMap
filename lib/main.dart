import 'package:aviationmap/features/map/widgets/map_screen.dart';
import 'package:flutter/material.dart';

import 'dart:async';
import 'features/splash/widgets/splash_screen.dart';

import 'core/error_handler.dart';

void main() {
  setupGlobalErrorHandling();
  runApp(const ErrorBoundary(child: AviationMapApp()));
}

class ErrorBoundary extends StatefulWidget {
  final Widget child;
  const ErrorBoundary({required this.child, super.key});

  @override
  State<ErrorBoundary> createState() => _ErrorBoundaryState();
}

class _ErrorBoundaryState extends State<ErrorBoundary> {
  Object? _error;

  @override
  void initState() {
    super.initState();
    FlutterError.onError = (FlutterErrorDetails details) {
      setState(() {
        _error = details.exception;
      });
      FlutterError.presentError(details);
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return MaterialApp(
        home: Scaffold(
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error, color: Colors.red, size: 64),
                const SizedBox(height: 16),
                const Text(
                  'An unexpected error occurred.',
                  style: TextStyle(fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  _error.toString(),
                  style: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      );
    }
    return widget.child;
  }
}

class AviationMapApp extends StatelessWidget {
  const AviationMapApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AviationMap',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueGrey),
      ),
      home: const SplashToMap(),
    );
  }
}

class SplashToMap extends StatefulWidget {
  const SplashToMap({super.key});

  @override
  State<SplashToMap> createState() => _SplashToMapState();
}

class _SplashToMapState extends State<SplashToMap> {
  Timer? _navTimer;

  @override
  void initState() {
    super.initState();
    _navTimer = Timer(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => const MapScreen()));
      }
    });
  }

  @override
  void dispose() {
    _navTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
