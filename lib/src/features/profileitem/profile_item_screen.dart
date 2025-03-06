import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/profileitem/profile_item_view.dart';

class ProfileItemScreen extends StatelessWidget {
  const ProfileItemScreen({super.key});
  static const String routeName = 'profileItemScreen';

  @override
  Widget build(BuildContext context) {
    return ProfileItemView();
  }
}