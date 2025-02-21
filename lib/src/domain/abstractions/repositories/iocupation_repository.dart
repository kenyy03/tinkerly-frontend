import 'package:mobile_frontend/src/domain/domain.dart';

abstract class IOcupationRepository {
  Future<List<Ocupation>> getOcupations();
}