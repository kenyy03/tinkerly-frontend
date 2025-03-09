import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/professionalitem/professional_item_view.dart';

class ProfessionalItemScreen extends StatelessWidget {
  const ProfessionalItemScreen({super.key});
  static const String routeName = 'profileItemScreen';

  @override
  Widget build(BuildContext context) {
    return ProfessionalItemView();
  }
}