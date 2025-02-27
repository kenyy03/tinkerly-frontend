import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/config/themes/app_theme.dart';
import 'package:mobile_frontend/src/domain/routes/app_routes.dart';
import 'package:mobile_frontend/src/features/login/bloc/login_bloc.dart';
import 'package:mobile_frontend/src/features/login/components/login_button.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';
import 'package:mobile_frontend/src/utils/helpers/helper.dart';
import 'package:quickalert/quickalert.dart';

class LoginPageForm extends StatefulWidget {
  const LoginPageForm({super.key});

  @override
  State<LoginPageForm> createState() => _LoginPageFormState();
}

class _LoginPageFormState extends State<LoginPageForm> {
  final _key = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late String _email;
  late String _password;

  bool isPasswordShown = false;
  onPassShowClicked() {
    isPasswordShown = !isPasswordShown;
    setState(() {});
  }

  onLogin() {
    final bool isFormOkay = _key.currentState?.validate() ?? false;
    if (isFormOkay) {
      _key.currentState?.save();

      BlocProvider.of<LoginBloc>(context)
          .add(LoginPressed(email: _email, password: _password));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(
      listener: (context, state) {
        if(state is LoginFailure){
          _email = '';
          _password = '';
          _emailController.clear();
          _passwordController.clear();
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: state.mensajeError
          );
        }
        if(state is UserAutenticateSuccess){
          context.pushReplacement(AppRoutes.home);
        }
      },
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Theme(
            data: AppTheme.defaultTheme.copyWith(
              inputDecorationTheme: AppTheme.secondaryInputDecorationTheme,
            ),
            child: Padding(
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Form(
                key: _key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Phone Field
                    const Text("Email"),
                    const SizedBox(height: 8),
                    TextFormField(
                      validator: Validators.email.call,
                      textInputAction: TextInputAction.next,
                      controller: _emailController,
                      onSaved: (newValue) {
                        _email = newValue ?? '';
                      },
                    ),
                    const SizedBox(height: AppDefaults.padding),

                    // Password Field
                    const Text("Password"),
                    const SizedBox(height: 8),
                    TextFormField(
                      validator: Validators.password.call,
                      onFieldSubmitted: (v) => onLogin(),
                      controller: _passwordController,
                      onSaved: (newValue) {
                        _password = newValue ?? '';
                      },
                      textInputAction: TextInputAction.done,
                      obscureText: !isPasswordShown,
                      decoration: InputDecoration(
                        suffixIcon: Material(
                          color: Colors.transparent,
                          child: IconButton(
                            onPressed: onPassShowClicked,
                            icon: SvgPicture.asset(
                              AppIcons.eye,
                              width: 24,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Forget Password labelLarge
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          // Navigator.pushNamed(
                          //     context, AppRoutes.forgotPassword);
                        },
                        child: const Text('Forget Password?'),
                      ),
                    ),

                    // Login labelLarge
                    state is LoginLoading ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircularProgressIndicator(),
                      ],
                    )
                    : LoginButton(onPressed: onLogin),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
