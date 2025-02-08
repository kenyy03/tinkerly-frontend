import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/domain/routes/app_routes.dart';
import 'package:mobile_frontend/src/features/login/login_screen.dart';
import 'package:mobile_frontend/src/features/signup/signup_screen.dart';

// GoRouter configuration
final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      name: AppRoutes.login, // Optional, add name to your routes. Allows you navigate by name instead of path
      path: '/',
      builder: (context, state) => LoginScreen(),
    ),
    GoRoute(
      name: AppRoutes.signup,
      path: '/signup',
      builder: (context, state) => SignUpScreen(),
    ),
  ],
);
