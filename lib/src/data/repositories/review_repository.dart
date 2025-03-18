import 'package:mobile_frontend/src/domain/domain.dart';

class ReviewRepository extends IReviewRepository {
  final IReviewDataSource _dataSource;
  
  ReviewRepository({ required IReviewDataSource dataSource }) 
    : _dataSource = dataSource;
  
  @override
  Future<List<Review>> getReviewsByUser({required String userId}) {
    return _dataSource.getReviewsByUser(userId: userId);
  }
}