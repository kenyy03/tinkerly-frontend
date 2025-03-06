import 'dart:io';

import 'package:mobile_frontend/src/domain/domain.dart';

abstract class IAuthRepository {
  Future<User> signUp({required User user});
  Future<User> login({required String email,required String password});
  Future<User> uploadImageProfile({required File file,required String id});
  Future<User> updateUser({required User user, bool isDelete});
  Future<List<UserForResumeDto>> getUserForHomeResume();
}