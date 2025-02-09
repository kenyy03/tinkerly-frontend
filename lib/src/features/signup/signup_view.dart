import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/signup/components/signup_form.dart';
import 'package:mobile_frontend/src/features/signup/components/signup_header.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key, required this.roleId});
  final String roleId;

  @override
  Widget build(BuildContext context) {
    print(roleId);
    return Scaffold(
      backgroundColor: AppColors.scaffoldWithBoxBackground,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SignUpHeader(),
                // SizedBox(height: AppDefaults.padding),
                SignUpForm()
              ],
            ),
          ),
        )
      ),
    );
  }
}