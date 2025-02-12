import 'package:mobile_frontend/src/domain/domain.dart';

class AuthRepository extends IAuthRepository {
  final IAuthDataSource _datasource;

  AuthRepository({required IAuthDataSource datasource}) : _datasource = datasource;

  @override
  Future<User> signUp({required User user}) {
    return _datasource.signUp(user: user);
  }
}