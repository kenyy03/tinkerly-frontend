import 'package:mobile_frontend/src/domain/domain.dart';

class AbilityRepository extends IAbilityRepository {
  final IAbilityDataSource _dataSource;

  AbilityRepository({required IAbilityDataSource dataSource}) : _dataSource = dataSource;
  @override
  Future<List<UserAbility>> getAbilitiesByUser({required String userId}) {
    return _dataSource.getAbilitiesByUser(userId: userId);
  }

  @override
  Future<List<Ability>> getAllAbilities() {
    return _dataSource.getAllAbilities();
  }
  
  @override
  Future<bool> insertAbilitiesForUser({required List<UserAbility> abilitiesForUser}) {
    return _dataSource.insertAbilitiesForUser(abilitiesForUser: abilitiesForUser);
  }
  
  @override
  Future<List<Ability>> insertAbilities({required List<Ability> abilities}) {
    return _dataSource.insertAbilities(abilities: abilities);
  }
}