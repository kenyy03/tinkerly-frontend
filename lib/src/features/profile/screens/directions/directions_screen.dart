import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/profile/screens/directions/directions_view.dart';

class DirectionsScreen extends StatelessWidget {
  const DirectionsScreen({super.key, required this.currentUserId});
  static const String routeName = 'directionScreen'; 
  final String currentUserId;
  @override
  Widget build(BuildContext context) {
    return DirectionsView(currentUserId: currentUserId);
  }
}