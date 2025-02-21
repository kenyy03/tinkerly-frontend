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

}