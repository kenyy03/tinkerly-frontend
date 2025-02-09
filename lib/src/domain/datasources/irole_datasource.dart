import 'package:mobile_frontend/src/domain/models/role.dart';

abstract class IRoleDataSource {
  Future<List<Role>> getRoles();
}