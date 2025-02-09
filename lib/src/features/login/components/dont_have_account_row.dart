import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/domain/routes/app_routes.dart';


class DontHaveAccountRow extends StatelessWidget {
  const DontHaveAccountRow({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text('Don\'t Have Account?'),
        TextButton(
          onPressed: () => context.push(AppRoutes.joinAsRole),
          child: const Text('Sign Up'),
        ),
      ],
    );
  }
}
