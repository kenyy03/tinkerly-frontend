part of 'review_cubit.dart';

sealed class ReviewState extends Equatable {
  const ReviewState({ this.reviews = const []});
  
  final List<Review> reviews;
  @override
  List<Object> get props => [reviews];
}

final class ReviewInitial extends ReviewState {}

final class ReviewLoading extends ReviewState {
  final String message;

  const ReviewLoading({super.reviews, required this.message});
}
final class ReviewFailure extends ReviewState {
  final String messageError;

  const ReviewFailure({required this.messageError}) : super();
}
final class ReviewsObtained extends ReviewState {
  final List<Review> reviewsObtained;

  const ReviewsObtained({required this.reviewsObtained}) 
    : super(reviews: reviewsObtained);
}
