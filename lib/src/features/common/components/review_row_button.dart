import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';


class ReviewRowButton extends StatelessWidget {
  const ReviewRowButton({
    super.key,
    required this.totalStars,
  });

  final int totalStars;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
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
            rating: 3,
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
    );
  }
}
