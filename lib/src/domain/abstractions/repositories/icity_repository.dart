import 'package:mobile_frontend/src/domain/domain.dart';

abstract class ICityRepository{
    Future<List<City>> getCities();
}