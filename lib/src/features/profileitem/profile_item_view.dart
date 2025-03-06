import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/features/profileitem/components/profile_tile_square.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class ProfileItemView extends StatelessWidget {
  const ProfileItemView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Profesionales', textAlign: TextAlign.center),
          ],
        ),
        // leading: const AppBackButton(),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.only(top: AppDefaults.padding),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          childAspectRatio: 0.85,
        ),
        itemCount: 16,
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              color: AppColors.gray
            ),
          );
          // return ProfileTileSquare(
          //   // data: Dummy.products.first,
          // );
        },
      ),
    );
  }
}