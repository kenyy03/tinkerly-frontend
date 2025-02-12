
import 'dart:convert';

import 'package:mobile_frontend/src/config/environment/environment.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:http/http.dart' as http;
import 'package:mobile_frontend/src/domain/stores/role_store.dart';

class AuthDataSource extends IAuthDataSource {
  @override
  Future<User> signUp({required User user}) async {
    try {
      RoleStore stored = RoleStore();
      final roles = await stored.get('roles');
      final roleSelected = roles!.firstWhere((role) => role.isSelected);
      final userRequest = user.copyWith(role: roleSelected);
      Uri uri = Uri.parse('${environment.baseUrl}/signup');
      String body = json.encode(userRequest.toJson());
      final response = await http.post(
        uri, 
        headers: { 'Content-Type': 'application/json', }, 
        body: body
      );

      if(response.statusCode != 200){
        return Future.error('Ocurrio un error al crear la cuenta');
      }

      var jsonResponse = json.decode(response.body) as Map<String,dynamic>;
      return User.fromMap(jsonResponse['data']);
    } catch (e) {
      return Future.error(e);
    }
  }
}