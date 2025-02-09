import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/signup/signup_view.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key, required this.roleId});
  static const String routeName= 'signUpScreen';
  final String roleId;

  @override
  Widget build(BuildContext context) {
    return SignupView(roleId: roleId);
  }
}