
import 'package:mobile_frontend/src/domain/domain.dart';

class OcupationRepository extends IOcupationRepository {
  final IOcupationDataSource _dataSource;
  OcupationRepository({required IOcupationDataSource dataSource}) : _dataSource = dataSource;
  @override
  Future<List<Ocupation>> getOcupations() {
    return _dataSource.getOcupations();
  }

}