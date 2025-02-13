import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/signup/bloc/signup_bloc.dart';
import 'package:mobile_frontend/src/features/signup/components/already_have_account.dart';
import 'package:mobile_frontend/src/features/signup/components/signup_button.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';
import 'package:mobile_frontend/src/utils/helpers/helper.dart';
import 'package:quickalert/quickalert.dart';

class SignUpForm extends StatelessWidget {
  final String roleId;
  SignUpForm({
    super.key,
    this.roleId = '',
  });

  final TextEditingController namesController = TextEditingController();
  final TextEditingController lastNamesController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is UserCreatedSuccess) {
          context.pushReplacement(AppRoutes.home);
        }
        if (state is SignUpFailure) {
          passwordController.clear();
          phoneController.clear();
          emailController.clear();
          lastNamesController.clear();
          namesController.clear();
          QuickAlert.show(
            context: context,
            type: QuickAlertType.error,
            text: state.mensajeError
          );
          return;
        }
      },
      child: Container(
        margin: const EdgeInsets.all(AppDefaults.margin),
        padding: const EdgeInsets.all(AppDefaults.padding),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: AppDefaults.boxShadow,
          borderRadius: AppDefaults.borderRadius,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Nombres"),
            const SizedBox(height: 8),
            TextFormField(
              validator: Validators.requiredWithFieldName('Name').call,
              textInputAction: TextInputAction.next,
              controller: namesController,
              onChanged: (value) {
                context.read<SignupBloc>().add(NamesOnChanged(names: value));
              },
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Apellidos"),
            const SizedBox(height: 8),
            TextFormField(
              validator: Validators.requiredWithFieldName('LastName').call,
              textInputAction: TextInputAction.next,
              controller: lastNamesController,
              onChanged: (value) {
                context
                    .read<SignupBloc>()
                    .add(LastNamesOnChanged(lastNames: value));
              },
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Email"),
            const SizedBox(height: 8),
            TextFormField(
              textInputAction: TextInputAction.next,
              validator: Validators.email.call,
              controller: emailController,
              onChanged: (value) {
                context.read<SignupBloc>().add(EmailOnChanged(email: value));
              },
            ),
            const SizedBox(height: AppDefaults.padding),
            const Text("Telefono"),
            const SizedBox(height: 8),
            TextFormField(
              textInputAction: TextInputAction.next,
              validator: Validators.required.call,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              controller: phoneController,
              onChanged: (value) {
                context.read<SignupBloc>().add(PhoneOnChanged(phone: value));
              },
            ),
            const SizedBox(height: AppDefaults.padding),
            _TextFormFieldPassword(roleId, controller: passwordController),
            // const SizedBox(height: AppDefaults.padding),
            const SignUpButton(),
            const AlreadyHaveAnAccount(),
            // const SizedBox(height: AppDefaults.padding),
          ],
        ),
      ),
    );
  }
}

class _TextFormFieldPassword extends StatefulWidget {
  const _TextFormFieldPassword(this.roleId, {required this.controller});
  final String roleId;
  final TextEditingController controller;

  @override
  State<_TextFormFieldPassword> createState() => _TextFormFieldPasswordState();
}

class _TextFormFieldPasswordState extends State<_TextFormFieldPassword> {
  bool isPasswordShown = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Contraseña"),
        const SizedBox(height: 8),
        TextFormField(
          validator: Validators.required.call,
          textInputAction: TextInputAction.next,
          obscureText: isPasswordShown,
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: Material(
              color: Colors.transparent,
              child: IconButton(
                onPressed: () {
                  isPasswordShown = !isPasswordShown;
                  setState(() {});
                },
                icon: SvgPicture.asset(
                  AppIcons.eye,
                  width: 24,
                ),
              ),
            ),
          ),
          onChanged: (value) async {
            context.read<SignupBloc>().add(PasswordOnChanged(password: value));
          },
        )
      ],
    );
  }
}
