import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/components/network_image.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class ProfessionalItemTileSquare extends StatelessWidget {
  const ProfessionalItemTileSquare({super.key, required this.data});

  final UserPublic data;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding / 2),
      child: Material(
        borderRadius: AppDefaults.borderRadius,
        color: AppColors.scaffoldBackground,
        child: InkWell(
          borderRadius: AppDefaults.borderRadius,
          onTap: () => context.push(AppRoutes.profileDetails),
          child: Container(
            width: 176,
            height: 296,
            padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding, vertical: AppDefaults.padding / 2),
            decoration: BoxDecoration(
              border: Border.all(width: 0.1, color: AppColors.placeholder),
              borderRadius: AppDefaults.borderRadius,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100,
                      height: 110,
                      padding: const EdgeInsets.all(AppDefaults.padding / 2),
                      child: AspectRatio(
                        aspectRatio: 1 / 1,
                        child: NetworkImageWithLoader(
                          data.imageProfile.url,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                SizedBox(
                  width: MediaQuery.of(context).size.shortestSide,
                  child: Text(
                    '${data.names} ${data.lastNames}',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: Colors.black),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.shortestSide,
                  child: Text(
                    data.userOcupation.ocupation.description,
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.shortestSide,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: _CustomChoiceChipList(data: data),
                  ),
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${data.userOcupation.serviceFee}',
                      style: Theme.of(context)
                        .textTheme.bodyLarge?.copyWith(color: Colors.black),
                    ),
                    RatingBarIndicator(
                      itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                      rating: 3,
                      itemCount: 5,
                      itemSize: 17,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _CustomChoiceChipList extends StatelessWidget {
  const _CustomChoiceChipList({
    required this.data,
  });

  final UserPublic data;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        3,
        (index) {
          return Container(
            margin: EdgeInsets.only(right: AppDefaults.padding),
            child: ChoiceChip(
              label: Text(
                data.userAbilities[index].ability.description, 
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.bold
                )
              ), 
              selected: false
            ),
          );
        }, 
      )
    );
  }
}