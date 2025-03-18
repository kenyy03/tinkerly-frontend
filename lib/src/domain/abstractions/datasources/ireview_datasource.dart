import '../../domain.dart';

abstract class IReviewDataSource {
  Future<List<Review>> getReviewsByUser({ required String userId });
}