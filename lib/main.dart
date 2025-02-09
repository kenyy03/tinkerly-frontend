import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/config/environment/environment.dart';
import 'package:mobile_frontend/src/config/routes/go_router.dart';
import 'package:mobile_frontend/src/config/themes/app_theme.dart';

void main() {
  Environment.initializeEnvironment();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      title: 'Tinkerly',
      theme: AppTheme.defaultTheme,
      // home: LoginScreen(),
    );
  }
}