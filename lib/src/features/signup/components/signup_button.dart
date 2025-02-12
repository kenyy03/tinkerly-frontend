import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/signup/bloc/signup_bloc.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';
import 'package:quickalert/quickalert.dart';
// import 'package:quickalert/quickalert.dart';

class SignUpButton extends StatefulWidget {
  const SignUpButton({
    super.key,
  });

  @override
  State<SignUpButton> createState() => _SignUpButtonState();
}

class _SignUpButtonState extends State<SignUpButton> {
  late User _user;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if(state is UserFilled){
          _user = state.user;
        }
        if(state is UserCreatedSuccess){
          context.pushReplacement(AppRoutes.home);
        }
        if(state is SignUpFailure){
          QuickAlert.show(context: context, type: QuickAlertType.error, text: state.mensajeError);
          return;
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding * 2),
        child: Row(
          children: [
            Text(
              'Sign Up',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: () {
                print('navegar al home navigation bar');
                context.read<SignupBloc>().add(CreateAccountPressed(user: _user));
              },
              style: ElevatedButton.styleFrom(elevation: 1),
              child: SvgPicture.asset(
                AppIcons.arrowForward,
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
