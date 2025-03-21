import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/components/user_resume_tile_square.dart';
import 'package:mobile_frontend/src/features/common/components/title_and_action_button.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';


class PopularUsers extends StatelessWidget {
  const PopularUsers({
    super.key,
    required this.usersData
  });

  final List<UserPublic> usersData;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TitleAndActionButton(
          title: 'Perfiles Populares',
          onTap: () => context.push(AppRoutes.popularItems),
        ),
        SingleChildScrollView(
          padding: const EdgeInsets.only(left: AppDefaults.padding),
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
              usersData.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: AppDefaults.padding),
                child: UserResumeTileSquare(data: usersData[index]),
              ),
            ),
          ),
        ),
        SizedBox(height: AppDefaults.margin)
      ],
    );
  }
}
