import 'package:mobile_frontend/src/domain/domain.dart';

abstract class IAbilityDataSource {
  Future<List<Ability>> getAllAbilities();
  Future<List<UserAbility>> getAbilitiesByUser({ required String userId });
  Future<bool> insertAbilitiesForUser({ required List<UserAbility> abilitiesForUser });
  Future<List<Ability>> insertAbilities({required List<Ability> abilities});
}