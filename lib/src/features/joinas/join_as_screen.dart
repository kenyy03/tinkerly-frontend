import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/joinas/join_as_view.dart';

class JoinAsScreen extends StatelessWidget {
  const JoinAsScreen({super.key});
  static const String routeName= 'joinAsScreen';

  @override
  Widget build(BuildContext context) {
    return JoinAsView();
  }
}