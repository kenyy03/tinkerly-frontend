import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class LoginPageHeader extends StatelessWidget {
  const LoginPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: AspectRatio(
            aspectRatio: 1 / 1,
            child: Container(
              // height: MediaQuery.of(context).size.height * 0.012,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(AppImages.roundedLogo)
                )
              ),
            ),
          ),
        ),
        Text(
          'Bienvenido a',
          style: Theme.of(context)
              .textTheme
              .titleLarge
              ?.copyWith(fontWeight: FontWeight.bold),
        ),
        Text(
          'Tinkerly',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
        )
      ],
    );
  }
}