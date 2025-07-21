import 'package:flutter/material.dart';
import 'features/splash/splash_screen.dart';
import 'features/map/map_screen.dart';

void main() {
  runApp(const AviationMapApp());
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
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MapScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
