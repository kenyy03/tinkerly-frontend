import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/components/app_back_button.dart';
import 'package:mobile_frontend/src/features/common/components/send_proposal_button.dart';
import 'package:mobile_frontend/src/features/common/components/pays_values_row.dart';
import 'package:mobile_frontend/src/features/common/components/profile_images_slider.dart';
import 'package:mobile_frontend/src/features/common/components/review_row_button.dart';
import 'package:mobile_frontend/src/features/professionalitem/components/custom_choice_chip_list.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class ProfessionalDetailsView extends StatelessWidget {
  const ProfessionalDetailsView({
    super.key,
    required this.userSelected,
  });

  final UserPublic userSelected;
  
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const AppBackButton(),
        title: const Text('Detalles del Perfil'),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
          child: SendProposalButton(
            onSendProposalButtonTap: () {},
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            ProfileImagesSlider(
              images: [
                userSelected.imageProfile.url
                // 'https://i.imgur.com/3o6ons9.png',
                // 'https://i.imgur.com/3o6ons9.png',
                // 'https://i.imgur.com/3o6ons9.png',
              ],
            ),
            SizedBox(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.all(AppDefaults.padding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${userSelected.names} ${userSelected.lastNames}',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 8),
                    Text(userSelected.userOcupation.ocupation.description),
                  ],
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
                child: PaysValuesRow(
                  serviceFee: userSelected.userOcupation.serviceFee,
                  hourleyRate: userSelected.userOcupation.hourlyRate,
                ),
              ),
            ),
            const SizedBox(height: 4),

            /// Product Details
            Container(
              width: width,
              padding: const EdgeInsets.all(AppDefaults.padding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Sobre mi',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                  ),
                  const SizedBox(height: 8),
                  Text(userSelected.description),
                ],
              ),
            ),
            const SizedBox(height: 8),
            // Abilities
            Container(
              width: width,
              padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding),
              child: Text(
                'Habilidades',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
              ),
            ),
            Container(
              width: width,
              padding: const EdgeInsets.only(left: AppDefaults.padding),
              child: CustomChoiceChipList(
                data: userSelected, 
                isWrap: true,
                itemCount: userSelected.userAbilities.length,
              ),
            ),
              
            const SizedBox(height: 8),
            /// Review Row
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: AppDefaults.padding,
              ),
              child: Column(
                children: [
                  Divider(thickness: 0.1),
                  ReviewRowButton(totalStars: 5),
                  Divider(thickness: 0.1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}