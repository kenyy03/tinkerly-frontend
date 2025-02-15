import 'dart:convert';

import 'package:mobile_frontend/src/config/environment/environment.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:http/http.dart' as http;


class CityDataSource extends ICityDataSource {
  @override
  Future<List<City>> getCities() async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/get-all-cities');
      final response = await http.get(uri);
      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }

      final jsonResponse = json.decode(response.body) as Map<String,dynamic>;
      final cities = List.from(jsonResponse['data']);
      return cities.map((element) => City.fromMap(element) ).toList();
    } catch (e) {
      return Future.error(e);
    }
  }
}