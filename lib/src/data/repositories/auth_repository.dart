import 'dart:io';

import 'package:mobile_frontend/src/domain/domain.dart';

class AuthRepository extends IAuthRepository {
  final IAuthDataSource _datasource;

  AuthRepository({required IAuthDataSource datasource}) : _datasource = datasource;

  @override
  Future<User> signUp({required User user}) {
    return _datasource.signUp(user: user);
  }
  
  @override
  Future<User> login({required String email, required String password}) {
    return _datasource.login(email: email, password: password);
  }

  @override
  Future<User> uploadImageProfile({required File file, required String id}) {
    return _datasource.uploadImageProfile(file: file, id: id);
  }
  
  @override
  Future<User> updateUser({required User user}) {
    return _datasource.updateUser(user: user);
  }
  
  @override
  Future<List<User>> getUserForHomeResume() {
    return _datasource.getUserForHomeResume();
  }
}