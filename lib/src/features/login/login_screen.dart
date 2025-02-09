import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/login/login_view.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName= 'loginScreen';

  @override
  Widget build(BuildContext context) {
    return LoginView();
  }
}