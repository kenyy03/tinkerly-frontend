import 'dart:convert';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';

class ReviewRowButton extends StatelessWidget {
  const ReviewRowButton({
    super.key,
    required this.totalStars,
    required this.reviews,
  });

  final double totalStars;
  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: InkWell(
        onTap: () {
          context.push(
            '${AppRoutes.profileItems}${AppRoutes.profileDetails}${AppRoutes.review}',
            extra: json.encode(reviews.map((e) => e.toJson()).toList())
          );
        },
        child: Row(
          children: [
            Text(
              'Review',
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
            ),
            const Spacer(),
            RatingBarIndicator(
              itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
              rating: totalStars,
              itemCount: 5,
              itemSize: 17,
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 18,
              color: AppColors.placeholder,
            ),
          ],
        ),
      ),
    );
  }
}
