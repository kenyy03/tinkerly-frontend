import 'package:mobile_frontend/src/domain/domain.dart';

abstract class IAuthRepository {
  Future<User> signUp({required User user});
  Future<User> login({required String email,required String password});
}