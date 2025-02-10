import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_frontend/src/features/signup/components/already_have_account.dart';
import 'package:mobile_frontend/src/features/signup/components/signup_button.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';
import 'package:mobile_frontend/src/utils/helpers/helper.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
          ),
          const SizedBox(height: AppDefaults.padding),
          const Text("Apellidos"),
          const SizedBox(height: 8),
          TextFormField(
            validator: Validators.requiredWithFieldName('LastName').call,
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: AppDefaults.padding),
          const Text("Email"),
          const SizedBox(height: 8),
          TextFormField(
            textInputAction: TextInputAction.next,
            validator: Validators.email.call,
          ),
          const SizedBox(height: AppDefaults.padding),
          const Text("Telefono"),
          const SizedBox(height: 8),
          TextFormField(
            textInputAction: TextInputAction.next,
            validator: Validators.required.call,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: AppDefaults.padding),
          _TextFormFieldPassword(),
          // const SizedBox(height: AppDefaults.padding),
          const SignUpButton(),
          const AlreadyHaveAnAccount(),
          // const SizedBox(height: AppDefaults.padding),
        ],
      ),
    );
  }
}

class _TextFormFieldPassword extends StatefulWidget {
  const _TextFormFieldPassword();

  @override
  State<_TextFormFieldPassword> createState() => _TextFormFieldPasswordState();
}

class _TextFormFieldPasswordState extends State<_TextFormFieldPassword> {
  bool isPasswordShown = false;

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
        )
      ],
    );
  }
}
