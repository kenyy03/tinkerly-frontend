import 'package:mobile_frontend/src/domain/domain.dart';

abstract class IOcupationRepository {
  Future<List<Ocupation>> getOcupations();
  Future<List<Ocupation>> createOcupations({ required List<Ocupation> newOcupations });
  Future<bool> assignOcupationToUser({ required UserOcupation userOcupation });
  Future<UserOcupation> getOcupationByUserId({ required String userId });
}