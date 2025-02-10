import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/home/home_view.dart';

class HomenScreen extends StatelessWidget {
  const HomenScreen({super.key});
  static const String routeName = 'homeScreen';

  @override
  Widget build(BuildContext context) {
    return HomeView();
  }
}