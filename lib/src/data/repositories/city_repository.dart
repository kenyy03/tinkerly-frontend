import 'package:mobile_frontend/src/domain/domain.dart';

class CityRepository extends ICityRepository {
  final ICityDataSource _dataSource;

  CityRepository({required ICityDataSource dataSource}) : _dataSource = dataSource;
  @override
  Future<List<City>> getCities() {
    return  _dataSource.getCities();
  }
}