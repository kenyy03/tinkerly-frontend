import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/reviews/review_view.dart';

class ReviewScreen extends StatelessWidget {
  const ReviewScreen({super.key, required this.reviews});
  static String routeName = 'reviewScreen';
  final List<Review> reviews;

  @override
  Widget build(BuildContext context) {
    return ReviewView(reviews: reviews);
  }
}