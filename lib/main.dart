import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/config/environment/environment.dart';
import 'package:mobile_frontend/src/config/routes/go_router.dart';
import 'package:mobile_frontend/src/config/storage/shared_prefs.dart';
import 'package:mobile_frontend/src/config/themes/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Environment.initializeEnvironment();
  await SharedPrefs.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      title: 'Tinkerly',
      theme: AppTheme.defaultTheme,
      // home: LoginScreen(),
    );
  }
}