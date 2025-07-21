import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../features/splash/splash_screen.dart';
import '../features/map/map_screen.dart';

/// Central route configuration for AviationMap ✈️
final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/map', builder: (context, state) => const MapScreen()),
  ],
);
