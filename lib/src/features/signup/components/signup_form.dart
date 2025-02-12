import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/domain/stores/role_store.dart';
import 'package:mobile_frontend/src/features/signup/bloc/signup_bloc.dart';
import 'package:mobile_frontend/src/features/signup/components/already_have_account.dart';
import 'package:mobile_frontend/src/features/signup/components/signup_button.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';
import 'package:mobile_frontend/src/utils/helpers/helper.dart';

class SignUpForm extends StatelessWidget {
  final String roleId;
  const SignUpForm({
    super.key,
    this.roleId = '',
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
            onChanged: (value) {
              context.read<SignupBloc>().add(LastNamesOnChanged(lastNames: value));
            },
          ),
          const SizedBox(height: AppDefaults.padding),
          const Text("Email"),
          const SizedBox(height: 8),
          TextFormField(
            textInputAction: TextInputAction.next,
            validator: Validators.email.call,
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
            onChanged: (value) {
              context.read<SignupBloc>().add(PhoneOnChanged(phone: value));
            },
          ),
          const SizedBox(height: AppDefaults.padding),
          _TextFormFieldPassword(roleId),
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
  const _TextFormFieldPassword(this.roleId);
  final String roleId;

  @override
  State<_TextFormFieldPassword> createState() => _TextFormFieldPasswordState();
}

class _TextFormFieldPasswordState extends State<_TextFormFieldPassword> {
  bool isPasswordShown = true;
  final rolesStore = RoleStore();
  late List<Role>? _rolesStored;

  @override
  void initState() {
    loadRoles();
    super.initState();
  }

  void loadRoles() async {
    _rolesStored = await rolesStore.get('roles');
  }

  @override
  Widget build(BuildContext context) {
    final signUpBloc = BlocProvider.of<SignupBloc>(context, listen: false);
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
          onChanged: (value) async {
            final role = _rolesStored?.firstWhere((roleStored) => roleStored.id == widget.roleId );
            signUpBloc.add(PasswordOnChanged(password: value, role: role!));
          },
        )
      ],
    );
  }
}
