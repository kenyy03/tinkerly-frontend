import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/profile/components/profile_square_tile.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class ProfileHeaderOptions extends StatelessWidget {
  const ProfileHeaderOptions({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(AppDefaults.padding),
      padding: const EdgeInsets.all(AppDefaults.padding),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: AppDefaults.borderRadius,
        boxShadow: AppDefaults.boxShadow,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          ProfileSquareTile(
            label: 'Contratos',
            icon: AppIcons.fileContract,
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.myOrder);
            },
          ),
          ProfileSquareTile(
            label: 'Foto',
            icon: AppIcons.cameraOutlined,
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.coupon);
            },
          ),
          ProfileSquareTile(
            label: 'Reseñas',
            icon: AppIcons.review,
            onTap: () {
              // Navigator.pushNamed(context, AppRoutes.deliveryAddress);
            },
          ),
        ],
      ),
    );
  }
}
