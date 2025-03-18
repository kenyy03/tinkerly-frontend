

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:mobile_frontend/src/config/environment/environment.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:mobile_frontend/src/features/common/services/services.dart';

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

  @override
  Future<User> updateUser({required User user, bool isDelete = false}) async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/update-user')
        .replace(queryParameters: {'isDelete': isDelete.toString()} as Map<String,dynamic>);
      String body = json.encode(user.toJson());
      final response = await http.put(
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
  Future<List<UserPublic>> getUserForHomeResume() async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/get-public-users-for-resume');
      final response = await http.get(
        uri, 
        headers: { 'Content-Type': 'application/json', }, 
      );

      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }

      final jsonResponse = json.decode(response.body) as Map<String,dynamic>;
      final usersResponse = List.from(jsonResponse['data']);
      final usersHome = usersResponse.map((e) => UserPublic.fromMap(e)).toList();
      final stored = UsersStorage();
      await stored.save('usersHome', usersHome);
      return usersHome;
    } catch (e) {
      return Future.error(e);
    }
  }
  
  @override
  Future<User> publishProfile({required bool isPublicProfile, required String userId}) async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/public-profile');
      final response = await http.put(
        uri, 
        headers: { 'Content-Type': 'application/json', }, 
        body: json.encode({ '_id': userId, 'isPublicProfile': isPublicProfile } as Map<String,dynamic>),
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
  Future<List<UserPublic>> getUsersByIsPublicProfile() async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/get-users-by-is-public-profile');
      final response = await http.get(
        uri, 
        headers: { 'Content-Type': 'application/json', }, 
      );

      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }

      final jsonResponse = json.decode(response.body) as Map<String,dynamic>;
      final usersResponse = List.from(jsonResponse['data']);
      return usersResponse.map((e) => UserPublic.fromMap(e)).toList();
    } catch (e) {
      return Future.error(e);
    }
  }
}