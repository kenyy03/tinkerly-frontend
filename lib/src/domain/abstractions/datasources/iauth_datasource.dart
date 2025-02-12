import 'package:mobile_frontend/src/domain/domain.dart';

abstract class IAuthDataSource {
  Future<User> signUp({required User user});
}