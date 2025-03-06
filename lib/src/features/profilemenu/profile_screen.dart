import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/profilemenu/profile_view.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const String routeName = 'profileScreen';

  @override
  Widget build(BuildContext context) {
    return ProfileView();
  }
}