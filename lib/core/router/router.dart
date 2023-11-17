import 'package:eden_user_app/core/reusables/error_screen.dart';
import 'package:eden_user_app/features/onboarding/presentation/login_page.dart';
import 'package:eden_user_app/features/onboarding/presentation/splash_screen.dart';
import 'package:eden_user_app/features/order/presentation/home_page.dart';
import 'package:eden_user_app/features/order/presentation/track_order_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/${SplashScreen.routeName}',
      name: SplashScreen.routeName,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/${LoginPage.routeName}',
      name: LoginPage.routeName,
      builder: (context, state) => const LoginPage(),
    ),
    GoRoute(
      path: '/${HomePage.routeName}',
      name: HomePage.routeName,
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/${TrackOrderPage.routeName}',
      name: TrackOrderPage.routeName,
      builder: (context, state) => TrackOrderPage(),
    ),
  ],
  initialLocation: '/${SplashScreen.routeName}',
  navigatorKey: navigatorKey,
  debugLogDiagnostics: true,
  errorBuilder: (context, state) =>
      const ErrorScreen(message: "Something went wrong"),
);

/// Route observer to use with RouteAware
final RouteObserver<ModalRoute<void>> routeObserver =
    RouteObserver<ModalRoute<void>>();
