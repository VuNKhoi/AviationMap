import 'package:aviationmap/features/map/widgets/map_screen.dart';
import 'package:go_router/go_router.dart';
import '../features/splash/widgets/splash_screen.dart';

/// Central route configuration for AviationMap ✈️
final GoRouter router = GoRouter(
  routes: [
    GoRoute(path: '/', builder: (context, state) => const SplashScreen()),
    GoRoute(path: '/map', builder: (context, state) => MapScreen()),
  ],
);
