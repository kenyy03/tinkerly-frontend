import '../../domain.dart';

abstract class IReviewRepository {
  Future<List<Review>> getReviewsByUser({ required String userId });
}