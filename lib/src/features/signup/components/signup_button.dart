import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_frontend/src/features/signup/bloc/signup_bloc.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';
class SignUpButton extends StatelessWidget {
  const SignUpButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupBloc, SignupState>(
      builder: (context, state) {
        if(state is SignUpLoading){
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: AppDefaults.padding * 2),
            child: Row(
              mainAxisAlignment:  MainAxisAlignment.center,
              children: [
                Text(state.mensaje),
                SizedBox(height: AppDefaults.margin),
                CircularProgressIndicator()
              ],
            ),
          );
        }
    
        return Padding(
          padding:
              const EdgeInsets.symmetric(vertical: AppDefaults.padding * 2),
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
                  context.read<SignupBloc>().add(CreateAccountPressed());
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
        );
      },
    );
  }
}
