

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mobile_frontend/src/config/environment/environment.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/services/stores/role_store.dart';
import 'package:mobile_frontend/src/features/common/services/stores/user_store.dart';

class AuthDataSource extends IAuthDataSource {
  @override
  Future<User> signUp({required User user}) async {
    try {
      RoleStore stored = RoleStore();
      final roles = stored.get('roles');
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
        return Future.error(json.decode(response.body)['message']);
      }

      final jsonResponse = json.decode(response.body) as Map<String,dynamic>;
      final userResponse = User.fromMap(jsonResponse['data']);
      final userStored = UserStorage();
      await userStored.save('user', userResponse);
      return userResponse;
    } catch (e) {
      return Future.error(e);
    }
  }
  
  @override
  Future<User> login({required String email, required String password}) async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/login');
      String body = json.encode({
        'email': email,
        'password': password
      });
      final response = await http.post(
        uri, 
        headers: { 'Content-Type': 'application/json', }, 
        body: body
      );

      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }

      final jsonResponse = json.decode(response.body) as Map<String,dynamic>;
      final userResponse = User.fromMap(jsonResponse['data']);
      final stored = UserStorage();
      await stored.save('user', userResponse);
      return userResponse;
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<User> uploadImageProfile({required File file, required String id}) async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/change-image-profile');

      final MultipartRequest request = http.MultipartRequest('PUT', uri);
      final multipartFile = await http.MultipartFile.fromPath(
        'imageProfile',
        file.path
      );
      request.files.add(multipartFile);
      request.fields['_id'] = id;

      final response = await request.send();
      if(response.statusCode != 200){
        return Future.error('Error al subir la imagen');
      }
      
      final responseString = await response.stream.bytesToString();
      final jsonResponse = json.decode(responseString);
      final userResponse = User.fromMap(jsonResponse['data']);
      final stored = UserStorage();
      // await stored.remove('user');
      await stored.save('user', userResponse);
      return userResponse;
    } catch (e) {
      return Future.error(e);
    }
  }
}