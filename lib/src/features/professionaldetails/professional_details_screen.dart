import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/professionaldetails/professional_details_view.dart';

class ProfessionalDetailsScreen extends StatelessWidget {
  const ProfessionalDetailsScreen({
    super.key,
    required this.userSelected,
  });

  static String routeName = 'professionalDetailsScreen';
  final UserPublic userSelected;
  
  @override
  Widget build(BuildContext context) {
    return ProfessionalDetailsView(userSelected: userSelected);
  }
} 