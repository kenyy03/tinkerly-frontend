

import 'package:mobile_frontend/src/domain/domain.dart';

abstract class ICityDataSource {
  Future<List<City>> getCities();
}