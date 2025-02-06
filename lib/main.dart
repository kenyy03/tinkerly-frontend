import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/config/themes/app_theme.dart';
import 'package:mobile_frontend/src/features/login/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinkerly',
      theme: AppTheme.defaultTheme,
      home: LoginScreen(),
    );
  }
}