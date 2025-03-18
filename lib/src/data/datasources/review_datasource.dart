import 'dart:convert';
import 'package:mobile_frontend/src/config/environment/environment.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:http/http.dart' as http;

class ReviewDatasource extends IReviewDataSource {
  @override
  Future<List<Review>> getReviewsByUser({required String userId}) async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/review/get-by-user')
        .replace(queryParameters: { 'userId': userId });
      
      final response = await http.get(uri);
      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }

      final jsonResponse = json.decode(response.body) as Map<String,dynamic>;
      final reviews = List.from(jsonResponse['data']);
      return reviews.map((element) => Review.fromMap(element) ).toList();
    } catch (e) {
      return Future.error(e);
    }
  }
}