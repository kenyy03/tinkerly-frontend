import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/common/components/network_image.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class LoginPageHeader extends StatelessWidget {
  const LoginPageHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.3,
          child: const AspectRatio(
            aspectRatio: 1 / 1,
            child: NetworkImageWithLoader(AppImages.roundedLogo),
          ),
        ),
        Text(
          'Welcome to our',
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