import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/profile/screens/directions/directions_view.dart';

class DirectionsScreen extends StatelessWidget {
  const DirectionsScreen({super.key});
  static const String routeName = 'directionScreen'; 

  @override
  Widget build(BuildContext context) {
    return DirectionsView();
  }
}