import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobile_frontend/src/domain/domain.dart';

part 'review_state.dart';

class ReviewCubit extends Cubit<ReviewState> {
  final IReviewRepository _reviewRepository;
  ReviewCubit({ required IReviewRepository reviewRepository }) 
    : _reviewRepository = reviewRepository, 
      super(ReviewInitial());

  void getReviewsByUser({ required String userId }) async {
    try {
      emit(ReviewLoading(message: 'Cargando reviews...', reviews: state.reviews));
      final result = await _reviewRepository.getReviewsByUser(userId: userId);
      emit(ReviewsObtained(reviewsObtained: result));
    } catch (e) {
      emit(ReviewFailure(messageError: e.toString()));
    }
  }
}
