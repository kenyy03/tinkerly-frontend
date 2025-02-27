
import 'package:mobile_frontend/src/domain/domain.dart';

class OcupationRepository extends IOcupationRepository {
  final IOcupationDataSource _dataSource;
  OcupationRepository({required IOcupationDataSource dataSource}) : _dataSource = dataSource;
  @override
  Future<List<Ocupation>> getOcupations() {
    return _dataSource.getOcupations();
  }
  
  @override
  Future<List<Ocupation>> createOcupations({required List<Ocupation> newOcupations}) {
    return _dataSource.createOcupations(newOcupations: newOcupations);
  }
  
  @override
  Future<bool> assignOcupationToUser({required UserOcupation userOcupation }) {
    return _dataSource.assignOcupationToUser(userOcupation: userOcupation);
  }
  
  @override
  Future<Ocupation> getOcupationByUserId({required String userId}) {
    return _dataSource.getOcupationByUserId(userId: userId);
  }
}