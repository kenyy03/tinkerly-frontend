import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/components/app_back_button.dart';
import 'package:mobile_frontend/src/features/common/components/network_image.dart';
import 'package:mobile_frontend/src/utils/constants/constants.dart';
import 'package:rating_summary/rating_summary.dart';

class ReviewView extends StatelessWidget {
  const ReviewView({super.key, required this.reviews});

  final List<Review> reviews;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: const AppBackButton(),
        title: Text(''),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppDefaults.padding *2, vertical: AppDefaults.padding),
          child: Column(
            children: [
              _ReviewTitle(),
              SizedBox(height: AppDefaults.margin),
              RatingSummary(
                counter: reviews.length,
                average: reviews.isEmpty ? 0.0 : ((reviews.map((r)=> r.rating).reduce((total, acum) => total + acum)) / reviews.length),
                showAverage: true,
                counterFiveStars: reviews.where((r) => r.rating == 5).length,
                counterFourStars: reviews.where((r) => r.rating == 4).length,
                counterThreeStars: reviews.where((r) => r.rating == 3).length,
                counterTwoStars: reviews.where((r) => r.rating == 2).length,
                counterOneStars: reviews.where((r) => r.rating == 1).length,
              ),
              Divider(thickness: 0.2),
              SizedBox(height: AppDefaults.padding *2),
              ListView.separated(
                separatorBuilder: (context, index) => Divider(thickness: 0.2),
                itemCount: reviews.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return SizedBox(
                    width: size.width,
                    child: Column(
                      children: [
                        _ReviewCommentHeader(
                          reviews: reviews, 
                          index: index
                        ),
                        SizedBox(height: AppDefaults.margin-7),
                        SizedBox(
                          width: size.width,
                          child: Text(reviews[index].comment),
                        )
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        )
      )
    );
  }
}

class _ReviewTitle extends StatelessWidget {
  const _ReviewTitle({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: SizedBox(
        child: Text(
          'Rating & Reviews',
          style:
              Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
        ),
      ),
    );
  }
}

class _ReviewCommentHeader extends StatelessWidget {
  const _ReviewCommentHeader({
    required this.reviews,
    required this.index
  });

  final List<Review> reviews;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 55,
          height: 55,
          child: ClipOval(
            child: AspectRatio(
              aspectRatio: 1 / 1,
              child: NetworkImageWithLoader(
                reviews[index].reviewerId.imageProfile.url
              ),
            ),
          ),
        ),
        SizedBox(width: AppDefaults.margin),
        SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${reviews[index].reviewerId.names} ${reviews[index].reviewerId.lastNames}',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.bold
                ),
              ),
              RatingBarIndicator(
                itemBuilder: (context, index) => Icon(Icons.star, color: Colors.amber),
                rating: reviews[index].rating,
                itemCount: 5,
                itemSize: 20,
              ),
            ],
          ),
        )
      ],
    );
  }
}