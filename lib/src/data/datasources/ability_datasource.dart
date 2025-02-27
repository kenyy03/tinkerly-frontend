import 'dart:convert';

import 'package:mobile_frontend/src/config/environment/environment.dart';
import 'package:mobile_frontend/src/domain/domain.dart';
import 'package:http/http.dart' as http;

class AbilityDataSource extends IAbilityDataSource {
  @override
  Future<List<UserAbility>> getAbilitiesByUser({required String userId}) async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/get-abilities-by-user-id')
        .replace(queryParameters: { 'userId': userId });

      final response = await http.get(uri, headers: { 'Content-Type': 'application/json', });

      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }

      final jsonResponse = json.decode(response.body) as Map<String,dynamic>;
      final userAbilities = List.from(jsonResponse['data']);
      return userAbilities.map((ability){
        return UserAbility.fromMap(ability);
      }).toList();        
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<List<Ability>> getAllAbilities() async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/get-all-abilities');
      final response = await http.get(uri, headers: { 'Content-Type': 'application/json', });

      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }

      final jsonResponse = json.decode(response.body) as Map<String,dynamic>;
      final abilities = List.from(jsonResponse['data']);
      return abilities.map((ability){
        return Ability.fromMap(ability);
      }).toList();   
    } catch (e) {
      return Future.error(e);
    }
  }
  
  @override
  Future<List<Ability>> insertAbilities({required List<Ability> abilities}) async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/insert-abilities');
      String jsonBody = json.encode(abilities.map((e) => {'description': e.description}).toList());
      final response = await http.post(
        uri, 
        headers: {'Content-Type': 'application/json'}, 
        body: jsonBody
      );

      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }
      
      final jsonResponse = json.decode(response.body) as Map<String, dynamic>;
      final abilitiesResponse = List.from(jsonResponse['data']);
      return abilitiesResponse.map((e) => Ability.fromMap(e)).toList();
    } catch (e) {
      return Future.error(e);
    }
  }

  @override
  Future<bool> insertAbilitiesForUser({required List<UserAbility> abilitiesForUser}) async {
    try {
      Uri uri = Uri.parse('${environment.baseUrl}/insert-abilities-for-user')
        .replace(queryParameters: {'userId': abilitiesForUser[0].userId});
      String jsonBody = json.encode(abilitiesForUser.map((e) => {'userId': e.userId, 'abilityId': e.ability.id}).toList());
      final response = await http.post(
        uri, 
        headers: {'Content-Type': 'application/json'},
        body: jsonBody 
      );

      if(response.statusCode != 200){
        return Future.error(json.decode(response.body)['message']);
      }
      
      return Future.value(true);
    } catch (e) {
      return Future.error(e);
    }
  }
}