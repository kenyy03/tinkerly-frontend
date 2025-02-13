import 'dart:convert';

import 'package:mobile_frontend/src/config/environment/environment.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:http/http.dart' as http;

class RoleDatasource extends IRoleDataSource {
  @override
  Future<List<Role>> getRoles() async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/get-all-roles');
      final response = await http.get(uri);
      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }

      var jsonResponse = json.decode(response.body) as Map<String,dynamic>;
      final roles = List.from(jsonResponse['data']);
      return roles.map((element) => Role.fromMap(element) ).toList();
    } catch (e) {
      return Future.error(e);
    }
  }
}