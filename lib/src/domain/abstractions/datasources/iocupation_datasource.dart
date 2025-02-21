import 'package:mobile_frontend/src/domain/domain.dart';

abstract class IOcupationDataSource {
  Future<List<Ocupation>> getOcupations();
}