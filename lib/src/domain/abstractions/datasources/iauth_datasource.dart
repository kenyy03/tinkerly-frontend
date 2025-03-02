import 'dart:io';

import 'package:mobile_frontend/src/domain/domain.dart';

abstract class IAuthDataSource {
  Future<User> signUp({required User user});
  Future<User> login({required String email,required String password});
  Future<User> uploadImageProfile({required File file,required String id});
  Future<User> updateUser({required User user});
  Future<List<UserForResumeDto>> getUserForHomeResume();
}