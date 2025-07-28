import 'package:flutter/material.dart';
import 'dart:async';

/// SplashScreen displays the app branding and a loading indicator.
///
/// This widget is the entry point for app setup logic. Navigation to the main
/// map screen is handled by the parent (e.g., SplashToMap). Setup logic can be
/// added in the timer callback or via dependency injection for extensibility.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

/// State for SplashScreen. Handles timer and cleanup.
class _SplashScreenState extends State<SplashScreen> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(const Duration(seconds: 2), () {
      // Navigation handled by parent (SplashToMap)
      // Add setup logic here if needed
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey[900],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.flight_takeoff, size: 80, color: Colors.white),
            SizedBox(height: 24),
            Text(
              'AviationMap',
              style: TextStyle(color: Colors.white, fontSize: 28),
            ),
            SizedBox(height: 16),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
