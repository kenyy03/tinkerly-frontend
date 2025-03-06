import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/profilemenu/components/profile_header.dart';
import 'package:mobile_frontend/src/features/profilemenu/components/profile_menu_options.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.cardColor,
      child: Column(
        children: [
          ProfileHeader(),
          ProfileMenuOptions()
        ],
      ),
    );
  }
}