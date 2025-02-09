
import 'package:mobile_frontend/src/domain/domain.dart';

class RoleRepository extends IRoleRepository {
  final IRoleDataSource _dataSource;

  RoleRepository({required IRoleDataSource dataSource}) : _dataSource = dataSource;

  @override
  Future<List<Role>> getRoles() {
    return _dataSource.getRoles();
  }

}