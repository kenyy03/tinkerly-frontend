import 'dart:convert';

import 'package:mobile_frontend/src/config/environment/environment.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:http/http.dart' as http;

class OcupationDataSource extends IOcupationDataSource {
  @override
  Future<List<Ocupation>> getOcupations() async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/get-all-ocupations');
      final response = await http.get(uri);
      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }

      final jsonResponse = json.decode(response.body) as Map<String,dynamic>;
      final ocupations = List.from(jsonResponse['data']);
      return ocupations.map((element) => Ocupation.fromMap(element) ).toList();
    } catch (e) {
      return Future.error(e);
    }
  }
  
  @override
  Future<List<Ocupation>> createOcupations({required List<Ocupation> newOcupations}) async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/create-ocupation');
      final map = newOcupations.map((ocupation) => {'description': ocupation.description}).toList();
      final String requestJson = json.encode(map);
      final response = await http.post(
        uri,
        headers: { 'Content-Type': 'application/json', },
        body: requestJson
      );
      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }

      final jsonResponse = json.decode(response.body) as Map<String,dynamic>;
      final ocupations = List.from(jsonResponse['data']);
      return ocupations.map((element) => Ocupation.fromMap(element) ).toList();
    } catch (e) {
      return Future.error(e);
    }
  }
  
  @override
  Future<bool> assignOcupationToUser({required UserOcupation userOcupation}) async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/ocupation/assign-ocupation-to-user');
      final String requestJson = json.encode(userOcupation.toJson());
      final response = await http.post(
        uri,
        headers: { 'Content-Type': 'application/json', },
        body: requestJson
      );
      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<UserOcupation> getOcupationByUserId({ required String userId }) async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/ocupation/get-ocupation-by-user')
        .replace(queryParameters: { 'userId': userId });
      final response = await http.get(uri);
      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }

      final jsonResponse = json.decode(response.body) as Map<String,dynamic>;
      final ocupations = UserOcupation.fromMap(jsonResponse['data']);
      return ocupations;
    } catch (e) {
      return Future.error(e);
    }
  }
}