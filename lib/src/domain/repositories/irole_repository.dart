import 'package:mobile_frontend/src/domain/models/role.dart';

abstract class IRoleRepository {
  Future<List<Role>> getRoles();
}