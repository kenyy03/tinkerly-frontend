import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/login/components/dont_have_account_row.dart';
import 'package:mobile_frontend/src/features/login/components/login_page_form.dart';
import 'package:mobile_frontend/src/features/login/components/login_page_header.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                LoginPageHeader(),
                LoginPageForm(),
                DontHaveAccountRow()
              ],
            ) 
          ),
        ),
      ),
    );
  }
}